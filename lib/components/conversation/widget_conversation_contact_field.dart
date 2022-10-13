import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/entities/Conversation.dart';
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/components/widget_badge.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConversationContactField extends StatelessWidget{

  final Conversation conversation; 

  const ConversationContactField( { Key? key, required this.conversation } ) : super( key : key ); 

  @override
  Widget build( BuildContext context ){
    return InkWell( 
      onTap:(){ 
        debugPrint( Modular.get<Controller>().currentUser.id.toString() );
        navigatorPushNamed(
          context, '/view-conversation-room',
          arguments: { 
            'conversation' : conversation
          }
        );
      },
      child: Container( 
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 90, 
        decoration: BoxDecoration( 
          color: Colors.transparent, 
          border: Border( 
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.2), 
              width: 0.5
            )
          )
        ),
        child: Row( 
          children: [
            Avatar(
              avatar: conversation.receiverAvatar,
              width: 55,
              height: 55,
              borderColor: Colors.black.withOpacity(0.1)
            ), 
            Expanded( 
              child: Container( 
                width: double.infinity, 
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 15),
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.start, 
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [ 
                    Text( 
                      conversation.receiverName, 
                      maxLines: 1,
                      style: TextStyle( 
                        fontSize: 16.3, 
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.6)
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only( top: 7, bottom: 7, left: 9.6, right: 9.6),
                      decoration: BoxDecoration( 
                        color: conversation.author == true  ? Colors.grey : primaryColor,
                        borderRadius: (  
                          BorderRadius.only( 
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                          )
                        )
                      ),
                      child: Text(
                        conversation.content,
                        style: TextStyle( 
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis
                        )
                      )
                    ),
                  ],
                )
              )
            ), 
            Container( 
              width: 150,
              margin: EdgeInsets.all(10),
              child: Badge(
                textColor: Colors.grey,
                borderRadius: 100,
                bgColor: Colors.transparent,
                borderColor: Colors.transparent,
                text: dateTimeFormat(conversation.dateRegister, dateFormat: "HH:mm dd/MM/yy" )
              ),
            )
          ]
        )
      )
    );
  }
}