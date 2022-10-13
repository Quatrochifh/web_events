import 'package:appweb3603/components/loader/widget_list_item_person_avatar_name_loader.dart';
import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart';
import 'package:appweb3603/components/widget_empty_message.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:appweb3603/services/ConversationService.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../components/conversation/widget_conversation_contact_field.dart';

class ConversationRooms extends StatefulWidget{

  const ConversationRooms({Key? key}) : super(key: key);

  @override
  ConversationRoomsState createState() => ConversationRoomsState();
}

class ConversationRoomsState extends State<ConversationRooms> with PageComponent{ 

  final Controller controller  = Modular.get<Controller>();  

  List<ConversationContactField>? _contactFields;

  @override
  void initState(){
    super.initState();

    _fetchRooms();
  }


  void _fetchRooms() {
    showLoading();
    Modular.get<Controller>().event.then((event){
      Modular.get<ConversationService>().getMessagesRooms(event.id).then((results){
        hideLoading();
        _contactFields = [];
        if( results != null ){
          results.forEach((value){
            _contactFields!.add( 
              ConversationContactField( conversation: value )
            );
          });

          if( !mounted ) return;
          setState((){
            _contactFields = _contactFields;
          });

        }
      });
    });
  }

  @override
  

  @override
  Widget build( BuildContext context ){
    return content(
      color: Colors.white,
      body:
        ( _contactFields == null ) ?
           <Widget>[
            ListItemPersonAvatarNameLoader(),
            ListItemPersonAvatarNameLoader(),
            ListItemPersonAvatarNameLoader(),
            ListItemPersonAvatarNameLoader(),
            ListItemPersonAvatarNameLoader(),
            ListItemPersonAvatarNameLoader(),
            ListItemPersonAvatarNameLoader(),
          ]
        :
        ( _contactFields!.isEmpty ) 
            ? 
              <Widget>[
                EmptyMessage( 
                  message: "Você não tem nada na sua caixa de entrada. Que tal enviar umas mensagens para os participantes?",
                ) 
              ]
            :
            <Widget>[
              Expanded(
                child: ListView(
                  padding: noPadding,
                  children: _contactFields!
                ),
              )
            ],  
      drawer: NavDrawer(),
      header: TemplateAppBar( back: true, hideUser: true, event: controller.currentEvent, title: "Caixa de Mensagens", user: controller.currentUser )
    );
  }

}