import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/style.dart'; 
import 'package:flutter/material.dart';

class MessageFixed extends StatefulWidget{ 

  final String text; 

  final bool display;

  MessageFixed({Key? key, required this.text, required this.display}) : super(key: key);
  
  @override
  MessageFixedState createState() => MessageFixedState();
} 

class MessageFixedState extends State<MessageFixed>{ 

  bool? _display;
 
  void show() { 
    if(!mounted) return;
    setState((){ 
      _display = true; 
    });
  }

  void _hidden() { 
    if( !mounted ) return;
    setState((){ 
      _display = false; 
    });
  }

  @override
  Widget build(BuildContext context){

    if((widget.display && _display == null) || _display == true){
      return  SizedBox( 
        child: Container(
            clipBehavior: Clip.antiAlias,
            width: double.infinity - 20,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20), 
            decoration: BoxDecoration( 
              color: Colors.white,  
              border: Border.all(
                width: 0.5,
                color: primaryColor,
                style: BorderStyle.solid
              )
            ),
            child: Row( 
              children: [
                Expanded(
                  child: Text(
                    widget.text,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14.6,
                      color: primaryColor
                    )
                  ), 
                ),
                PrimaryButton(width: 70, fontSize: 15, onClick:  _hidden, title: "Entendi" )
              ],
            )
          ), 
        );
    }else{
      return SizedBox.shrink();
    }
     
  }
  
}