import 'package:appweb3603/bloc/Event.dart' as eventbloc;
import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/components/forms/search_participant_form.dart';
import 'package:appweb3603/components/loader/widget_list_item_person_avatar_name_loader.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_empty_box.dart';
import 'package:appweb3603/components/widget_list_component.dart';
import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/components/widget_user_card.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ParticipantsPage extends StatefulWidget {

  ParticipantsPage({Key? key}) : super(key: key);

  @override
  ParticipantsPageState createState() => new ParticipantsPageState();
} 

class ParticipantsPageState extends State<ParticipantsPage> with PageComponent {

  Controller controller  = Modular.get<Controller>();
  ScrollController _participantsScrollController =  ScrollController();
  List<Widget>? _participantsCards;
  Event? event;
  String? _searchTerm;
  int _currentPage = 1;
  bool _hasMoreParticipants = true;
  bool _showForm = false;
  double _currentParticipantsPointerPosition = 0.0;

  @override 
  void initState(){
    super.initState();    

    if (!mounted) return;

    _participantsScrollController.addListener(_participantsScrollControllerListener);
    _searchParticipant();
  }

  void _participantsScrollControllerListener() {
    _currentParticipantsPointerPosition = _participantsScrollController.position.pixels;

    if (mounted) {
      setState(() {
        _currentParticipantsPointerPosition = _currentParticipantsPointerPosition;
      });
    }

    if (_participantsScrollController.position.atEdge) {
      bool isTop = _participantsScrollController.position.pixels <= templateFooterHeigth;
      if (!isTop && _hasMoreParticipants) {
        _searchParticipant(name: _searchTerm);
      }
    }
  }

  ///
  /// Buscar por um participante
  ///
  void _searchParticipant({String? name, bool clean = false}) {
    if(name != null) {
      setState((){
        _searchTerm = name;
      });
    }else{
      setState((){
        _searchTerm = null;
      });
    }

    //Vamos exibir o loading
    showLoading();

    if(clean == true) {
      _currentPage       = 1;
      _participantsCards = [];
    }

    Modular.get<eventbloc.Event>().eventParticipants(name: name, page: _currentPage).then((results) {
      hideLoading();

      _participantsCards ??= [];

      if(results != null && results.isNotEmpty) {
        for(int i = 0; i < results.length; i++) {  
          User participant = results[i];
          _participantsCards!.add( 
            UserCard(
              key: GlobalKey(),
              user: participant
            )
          );
        }
        setState((){
          _currentPage +=1;
          _hasMoreParticipants = true;
          _participantsCards  = _participantsCards;
        });
      }else{
        setState((){
          _hasMoreParticipants = false;
          _participantsCards ??= [];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // Requer autenticação
    controller.requireAuthentication(context);

    return content(
      color: Colors.white,
      body: <Widget> [
        _showForm ?
          Container(
            padding: EdgeInsets.all(5),
            width: double.infinity, 
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.125),
              border: Border.all(
                color: Colors.grey.withOpacity(0.125)
              )
            ),
            child: Row( 
              children: [
                ((_searchTerm != null)) 
                  ?
                    PrimaryButton(
                      onClick: (){
                        _searchParticipant(clean: true);
                      },
                      marginRight: 20,
                      width: 50, 
                      height: 50, 
                      icon: CupertinoIcons.xmark,  
                      borderRadius: 100,
                      onlyIcon: true,
                      textColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      iconColor: primaryColor,
                    )
                  : 
                    SizedBox.shrink(),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(0),
                      child: SearchParticipantForm( 
                        feedback:({ name, clean }){ 
                          _currentPage = 1;
                          _searchParticipant(
                            name: name,
                            clean: clean
                          );
                        },
                        cancelOnclick: (){ },
                      )
                    )
                  )
              ]
            )
          )
        :
          SizedBox.shrink(),
        _searchTerm != null
          ?
            Message(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.only(top: 8, bottom: 6, left: 12, right: 12),
              borderRadius: 5, 
              bgColor: Colors.transparent,
              textColor: Colors.grey,
              textSpan: [ 
                TextSpan(text: "Buscando por: "), 
                TextSpan(text: _searchTerm, style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor))
              ],
            )
          :
            SizedBox.shrink(),
        (_participantsCards == null)
        ?
          Expanded(
            key: new GlobalKey(),
            child: ListComponent(
              children: const [
                ListItemPersonAvatarNameLoader(),
                ListItemPersonAvatarNameLoader(),
                ListItemPersonAvatarNameLoader(),
                ListItemPersonAvatarNameLoader(),
                ListItemPersonAvatarNameLoader()
              ]
            )
          )
        :
          (_participantsCards!.isNotEmpty)
          ?
            Expanded(
              child: ListView(
                padding: noPadding,
                controller: _participantsScrollController,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _participantsCards!
                  ),
                  (!_hasMoreParticipants)
                    ?
                      Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(
                          "Você chegou ao fim."
                        )
                      )
                    :
                      SizedBox.shrink()
                ]
              )
            )
          :
            EmptyBox(
              message: "Nenhum participante para exibir"
            )
      ],  
      drawer: NavDrawer(),
      header: TemplateAppBar(
        back: true,
        hideUser: true,
        event: controller.currentEvent,
        title: "Participantes",
        user: controller.currentUser,
        customButton: _searchTerm == null ? 
          PrimaryButton(
            onClick: (){
              setState((){
                if(!mounted) return;
                (!_showForm) ?
                  _showForm = true
                : 
                  _showForm = false;
              });
            },
            width: 40, 
            height: 40, 
            icon: _showForm ? FontAwesomeIcons.xmark : CupertinoIcons.search,  
            borderRadius: 100,
            iconSize: 16,
            onlyIcon: true,
            textColor: primaryColor,
            backgroundColor: primaryColorLigther,
          )
        :
          null
      )
    );
  } 
}