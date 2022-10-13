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

class SpeakersPage extends StatefulWidget{  

  SpeakersPage({Key? key}) : super(key: key);

  @override
  SpeakersPageState createState() => new SpeakersPageState();
} 

class SpeakersPageState extends State<SpeakersPage> with PageComponent{ 

  Controller controller  = Modular.get<Controller>();

  List<Widget>? _speakersCards;

  Event? event;

  String? _searchTerm;

  int _currentPage = 1;

  bool _showForm = false;

  @override 
  void initState() {
    super.initState();    

    if (!mounted) return;

    _searchParticipant();
  }

  void _searchParticipant({String? name, bool clean = false}) {

    if(name != null){
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
      _currentPage = 1;
      _speakersCards = [];
    }

    Modular.get<eventbloc.Event>().eventSpeakers(name: name, page: _currentPage).then((results) {
      //Vamos esconder o loading
      hideLoading();

      _speakersCards ??= [];

      if(results != null && results.isNotEmpty) {
        for(int i = 0; i < results.length; i++) {  
          User participant = results[i];
          _speakersCards!.add( 
            UserCard(
              key: GlobalKey(),
              user: participant
            )
          );
        }
        setState((){
          _speakersCards  = _speakersCards;
        });
      } else {
        setState((){
          _speakersCards ??= [];
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
      body: <Widget>[
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
        ( _searchTerm != null ) ?
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
        (_speakersCards == null)
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
          (_speakersCards!.isNotEmpty)
          ?
            Expanded(
              key: new GlobalKey(),
              child: ListComponent(children: _speakersCards!)
            )
          :
            EmptyBox(
              message: "Este evento ainda não tem palestrante."
            )
      ],  
      drawer: NavDrawer(),
      header: TemplateAppBar(
        back: true,
        hideUser: true,
        event: controller.currentEvent,
        title: "Palestrantes",
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