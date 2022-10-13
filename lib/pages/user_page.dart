import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/utils/Permissions.dart';
import 'package:appweb3603/bloc/Event.dart';
import 'package:appweb3603/entities/Event.dart' as event_entity;
import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/schedule/widget_schedule.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/components/widget_schedules_map.dart';
import 'package:appweb3603/components/widget_social_medias.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/enums/userEnum.dart';
import 'package:appweb3603/helpers.dart'; 
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/ContactService.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';  
import 'package:flutter/material.dart'; 
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/widget_details.dart';
import '../components/widget_empty_box.dart';
import '../entities/Conversation.dart'; 
 

class UserPage extends StatefulWidget {   

  final dynamic user;

  UserPage({Key? key, required this.user}) : super(key: key);

  @override
  UserPageState createState() => new UserPageState();
}


class UserPageState extends State<UserPage> with PageComponent {

  bool _speakersActivitiesLoaded = false;

  List<Schedule> _speakersActivities = [];

  @override
  void initState() {
    super.initState();

    if (widget.user.level == UserEnum.speaker) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Buscar por atividades do palestrantes
        (globalDIContainer.get(Event) as Event).eventActivities(speakerId: widget.user.speakerId).then((schedules){
          _speakersActivitiesLoaded = true;
          if(schedules != null){
            schedules.forEach((schedule) {
              _speakersActivities.add(
                Schedule(
                  hideSpeaker: true,
                  schedule: schedule,
                  event: globalDIContainer.get(event_entity.Event) as event_entity.Event
                )
              );
            });
            setState(() {
              _speakersActivities = _speakersActivities;
            });
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    Controller controller = Modular.get<Controller>();

    return content(
      color: Colors.white,
      body:  <Widget>[
        Expanded(
          child: ListView(
            padding: noPadding,
            children:[
              _UserPageHeader(user: widget.user),
              (widget.user.showProfile == false)
                ?
                  Message(
                    margin: EdgeInsets.all(10),
                    fontSize: 16.5,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                      top: 10
                    ),
                    text: "Este usuário limita quem poderá acessar seu perfil.",
                  )
                :
                  SizedBox.shrink(),
              (widget.user.showProfile == true)
              ?
                Details(
                  inline: true,
                  titleSize: 12,
                  titleColor: Colors.black,
                  descriptionColor: Colors.black,
                  titleFontWeight: FontWeight.w200,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  items: {
                    "Empresa" :(widget.user.company.isNotEmpty) ? widget.user.company : "Indisponível",
                    "Cargo" : (widget.user.role.isNotEmpty) ? widget.user.role : "Indisponível",
                  }
                )
              :
                SizedBox.shrink(),
              (widget.user.showProfile == true)
              ?
                Details(
                  inline: true,
                  titleSize: 12,
                  titleFontWeight: FontWeight.w200,
                  titleColor: Colors.black,
                  descriptionColor: Colors.black,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  items: {
                    "Telefone" : (widget.user.telephone.isNotEmpty) ? widget.user.telephone : "Indisponível",
                    "E-mail" : (widget.user.email.isNotEmpty) ? widget.user.email : "Indisponível"
                  }
                )
              :
                SizedBox.shrink(),
              (widget.user.level == UserEnum.speaker)
              ?
                Details(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20
                  ),
                  items: {
                    "Descrição" : (widget.user.description.isNotEmpty) ? widget.user.description : "Indisponível",
                  }
                )
              :
                SizedBox.shrink(),
              (widget.user.level == UserEnum.speaker)
                ?
                  (_speakersActivitiesLoaded == true && _speakersActivities.isNotEmpty)
                      ?
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight: 10
                          ),
                          color: Colors.white,
                          child: SchedulesMap(
                            schedules: _speakersActivities
                          )
                        )
                      :
                      (
                        (_speakersActivitiesLoaded == true)
                          ?
                            EmptyBox(message: "Nenhuma palestra encontrada")
                          :
                            LoadingBlock(
                              transparent: true,
                              text: "Carregando palestras ...",
                              textColor: Colors.grey,
                            )
                    )
                :
                  SizedBox.shrink()
            ]
          )
        )
      ], 
      drawer: NavDrawer(),
      header: TemplateAppBar(
        event: controller.currentEvent,
        back: true,
        hideMenu: true,
        hideUser: true,
        title: widget.user.level == UserEnum.speaker ? "Palestrante" : "Participante",
        user: controller.currentUser
      ),
    );   
             
  }
}  


class _UserPageHeader extends StatefulWidget {

  final dynamic user;

  _UserPageHeader({Key? key, this.user}) : super(key: key);

  @override
  _UserPageHeaderState createState() => _UserPageHeaderState();

}

class _UserPageHeaderState extends State<_UserPageHeader> {

  bool? _btnAddContactEnabled;

  @override
  void initState(){
    super.initState();

    this._verifyUserContact();
  }

  /*
   * Verifica se o usuário já consta na lista de contato do usuário
  */
  void _verifyUserContact() {
    ContactService contactService = (globalDIContainer.get(ContactService)) as ContactService;
    contactService.verifyUserIdContact(widget.user.id).then((results){
      if (results) {
        _btnAddContactEnabled = false;
      } else {
        _btnAddContactEnabled = true;
      }
      if (!mounted) return;
      setState((){
        _btnAddContactEnabled = _btnAddContactEnabled;
      });
    });
  }

  /*
   * Adicionar o usuário à lista de usuário
  */
  void _addToContactList() async {

    bool? hasPermission = await Permissions.checkContactPermission().then((permission){
      if (permission != true) {
        Permissions.requestContactPermission().then((results){
          if (results != PermissionStatus.granted) {
            showNotification(
              message: "Acesse as configurações e permita o acesso aos Contatos."
            );
            return false;
          }
        });
      } else {
        return true;
      }
    });

    if (hasPermission != true) return;

    ContactService contactService = (globalDIContainer.get(ContactService)) as ContactService;
    contactService.addContact(widget.user).then((results){
      if (results) {
        showNotification(message: "${widget.user.name} foi inserido em sua lista de contatos.", type: "success");
      } else {
        showNotification(message: "Não foi possível adicionar ${widget.user.name} na sua lista de contatos.", type: "error");
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: 450,
      child: Stack(
        children: [
          (widget.user.level == UserEnum.speaker)
          ?
            Container(
              height: 195,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.125),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.125)
                  )
                ),
              ),
              child: CustomImage(
                key: new GlobalKey(),
                width: double.infinity,
                height: 450,
                image: widget.user.background,
                fit: BoxFit.cover,
              ),
            )
          :
            SizedBox.shrink(),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 115),
                child: Avatar(
                  width: 170, 
                  height: 170,
                  borderRadius: 100,
                  avatar: widget.user.avatar, 
                  borderColor: Colors.transparent
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 10
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [ 
                        Text( 
                          widget.user.name,  
                          style: TextStyle( 
                            fontSize: 24,
                            fontWeight: FontWeight.bold, 
                            color: Colors.black87, 
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.5),
                          child: Text( 
                              (widget.user.company.isNotEmpty) ? widget.user.company : "Indisponível", 
                              style: TextStyle(
                                fontSize: 14, 
                                color: Colors.grey
                              ),
                            )
                        ),
                      ],
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      _btnAddContactEnabled == true 
                        ?
                          PrimaryButton(
                            onClick: (){
                              _addToContactList();
                            },
                            width: 50,
                            height: 40,
                            marginRight: 5,
                            iconSize: 20,
                            borderRadius: 100,
                            iconMargin: EdgeInsets.only(
                              left: 5,
                              right: 5
                            ),
                            iconColor: Colors.white,
                            icon: CupertinoIcons.person_add
                          )
                        :
                          PrimaryButton(
                            onClick: (){},
                            width: 50,
                            height: 40,
                            marginRight: 5,
                            iconSize: 20,
                            borderRadius: 100,
                            iconMargin: EdgeInsets.only(
                              left: 5,
                              right: 5
                            ),
                            iconColor: Colors.white,
                            backgroundColor: primaryColor.withOpacity(0.2),
                            icon: CupertinoIcons.person_2_fill
                          ),
                      PrimaryButton(
                        onClick: (){
                          navigatorPushNamed(
                            context, '/view-conversation-room',
                            arguments: {
                              'conversation':
                              Conversation(receiverID: widget.user.id)
                            }
                          );
                        },
                        width: 50,
                        height: 40,
                        marginRight: 5,
                        iconSize: 20,
                        borderRadius: 100,
                        iconMargin: EdgeInsets.only(
                          left: 5,
                          right: 5
                        ),
                        iconColor: Colors.white,
                        icon: CupertinoIcons.chat_bubble_2
                      ),
                    ]
                  ),
                  (widget.user.showProfile == true && widget.user.socialMedias.isNotEmpty) 
                    ? 
                      SocialMedias(
                        alignment: Alignment.center,
                        dimension: 40,
                        fontSize: 18,
                        items: widget.user.socialMedias,
                        margin: EdgeInsets.only(
                          top: 15,
                          bottom: 15
                        )
                      )
                    :
                      SizedBox.shrink()
                    ,
                ],
              )
            ], 
          )
        ]
      )
    );
  }
}