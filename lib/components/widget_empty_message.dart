import 'package:appweb3603/components/widget_message.dart';
import 'package:appweb3603/messages.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart'; 

class EmptyMessage extends StatelessWidget{ 

  final String? message;

  EmptyMessage( { Key? key, this.message } ) : super ( key : key );

  @override
  Widget build( BuildContext context ){
    return Container( 
      alignment: Alignment.center,
      margin: EdgeInsets.all(0),
      child: Message( 
        textAlign: TextAlign.center, 
        iconColor: grey165Color,
        margin: EdgeInsets.only(top: 50, left: 10, right: 10), 
        bgColor: Colors.transparent,
        text: message ?? globalMessages['NO_CONTENT'],
        textColor: grey165Color,
        fontSize: 16,
      )
    );
  }

}