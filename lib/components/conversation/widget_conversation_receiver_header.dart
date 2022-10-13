import 'package:appweb3603/components/widget_avatar.dart';
import 'package:flutter/material.dart';

class ConversationReceiverHeader extends StatefulWidget{

  final String receiverName;

  final String receiverAvatar;

  final String receiverCargo;

  const ConversationReceiverHeader({Key? key, required this.receiverCargo, required this.receiverName, required this.receiverAvatar}) : super( key : key );


  @override
  ConversationReceiverHeaderState createState() => ConversationReceiverHeaderState();
}

class ConversationReceiverHeaderState extends State<ConversationReceiverHeader>{ 

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity, 
      height: 60,
      child: Row(
        children: [ 
          Avatar(avatar: widget.receiverAvatar, borderColor: Colors.transparent), 
          Expanded( 
            child: Container( 
              width: double.infinity, 
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 15),
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [ 
                  Text( 
                    widget.receiverName, 
                    maxLines: 1,
                    style: TextStyle( 
                      fontSize: 22.6, 
                      color: Colors.black
                    ),
                  ),
                  Text( 
                    widget.receiverCargo, 
                    maxLines: 1,
                    style: TextStyle( 
                      fontSize: 12.6, 
                      color: Colors.black.withOpacity(0.25)
                    ),
                  )
                ],
              )
            )
          )
        ],
      )
    );
  }

}