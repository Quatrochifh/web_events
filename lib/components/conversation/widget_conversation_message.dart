import 'dart:convert';

import 'package:appweb3603/component_functions.dart';
import 'package:appweb3603/components/widget_avatar.dart';
import 'package:appweb3603/components/widget_custom_image.dart';  
import 'package:appweb3603/entities/Conversation.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/style.dart'; 
import 'package:flutter/material.dart'; 


class ConversationMessage extends StatefulWidget{  

  final Conversation conversation;

  final bool? rightPosition;

  final String? imageBase64;

  ConversationMessage({Key? key, this.rightPosition = false, required this.conversation, this.imageBase64}) : super(key: key);

  @override
  ConversationMessageState createState() => ConversationMessageState();
}


class ConversationMessageState extends State<ConversationMessage>{  

  @override
  Widget build(BuildContext context){
    return InkWell(
      key: new GlobalKey(),
      onTap: (){
        if (widget.conversation.attachmentUrl.isNotEmpty) {
          showFloatScreen(
            title: "Foto enviada às ${dateTimeFormat(widget.conversation.dateRegister, dateFormat: "HH:MM dd/MM/yy")}",
            headerItemColor: Colors.white,
            backgroundColor: Colors.black.withOpacity(0.75),
            child: Container(
              key: new GlobalKey(),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: CustomImage(
                image: widget.conversation.attachmentUrl,
                width: double.infinity,
                height: 250
              )
            )
          );
        }
      },
      child: Container(  
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.only(bottom: 3),
        child: Column( 
          crossAxisAlignment:widget.rightPosition == true ? CrossAxisAlignment.end : CrossAxisAlignment.start, 
          children: [
            (widget.imageBase64 != null || widget.conversation.attachmentUrl.isNotEmpty )
              ?
                Container(
                  width:MediaQuery.of(context).size.width * 0.73,
                  height: 220,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [darkShadow],
                    border: Border.all(
                      width: 0.5,
                      color: bgWhiteBorderColor
                    )
                  ),
                  margin: EdgeInsets.only(
                    top: 30,
                    bottom:10
                  ),
                  child: CustomImage(
                    key: new GlobalKey(),
                    width: 200,
                    height: 120,
                    fit: BoxFit.cover,
                    image: widget.imageBase64 != null ? Base64Decoder().convert(widget.imageBase64!) : widget.conversation.attachmentUrl,
                  ),
                )
              :
                SizedBox.shrink(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                ( widget.rightPosition != true )
                  ? 
                    Avatar( avatar: widget.conversation.senderAvatar, width: 35, height: 35, borderColor: Colors.transparent, margin: EdgeInsets.only( top: 5, right: 8 ), )
                  : 
                    SizedBox.shrink()
                ,
                Expanded( 
                  child: Column(  
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container( 
                        alignment: widget.rightPosition != true ? Alignment.centerLeft : Alignment.centerRight, 
                        child: Container(   
                          padding: EdgeInsets.only( 
                            top: 15, 
                            bottom: 15, 
                            left: 20, 
                            right: 20
                          ),
                          decoration: BoxDecoration(   
                            color: widget.rightPosition != true ? primaryColor : Colors.grey,
                            borderRadius: 
                            ( widget.rightPosition != true )
                              ?
                                (  
                                  BorderRadius.only( 
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  )
                                )
                              :
                                (  
                                  BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25), 
                                  )
                                )
                          ),
                          child: Text( 
                            widget.conversation.content,  
                            maxLines: 5,
                            softWrap: true,
                            style: TextStyle( 
                              fontSize: 15, 
                              color: Colors.white, 
                              overflow: TextOverflow.ellipsis
                            ),
                          ),  
                        )
                      ), 
                    ]
                  ) 
                ),
              ]  
            ), 
            Container(   
              margin: EdgeInsets.only(
                top: 5,
                left: widget.rightPosition == true ? 0 : 15,
                right: widget.rightPosition != true ? 0 : 15
              ),
              child: Text(
                dateTimeFormat(widget.conversation.dateRegister, dateFormat: "HH:mm - dd/MM"), 
                style: TextStyle( 
                  fontSize: 12, 
                  color: Colors.white,
                ),
              )
            )
          ] 
        )
      )
    );
  }
}