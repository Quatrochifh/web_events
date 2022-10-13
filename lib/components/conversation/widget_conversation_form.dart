import 'package:appweb3603/components/forms/conversation_form.dart' as form;
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class ConversationForm extends StatefulWidget {

  final User currentUser;

  final Function onSubmit;  

  ConversationForm({Key? key, required this.currentUser, required this.onSubmit}) : super(key : key);

  @override
  ConversationFormState createState() => ConversationFormState();
}

class ConversationFormState extends State<ConversationForm> {

  Future<dynamic> _submitMessage({String message = "", String? attachment}){
    return widget.onSubmit(message : message, attachment: attachment);
  } 

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: bgWhiteBorderColor,
            width: 0.5
          )
        )
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5, 
              color: Colors.black.withOpacity(0.125)
            )
          )
        ),  
        height: 70, 
        child: Row( 
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded( 
              child: form.ConversationForm(
                cancelOnclick: (){ },
                feedback: _submitMessage,
              )
            )
          ],
        )
      )
    );
  }
}