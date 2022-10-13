import 'package:flutter/material.dart';

class EmptyBox extends StatefulWidget{

  final String message;

  EmptyBox( { Key? key, this.message = "Nada para exibir" } ) : super( key : key );

  @override
  EmptyBoxState createState() => new EmptyBoxState();
}

class EmptyBoxState extends State<EmptyBox> { 

  @override 
  Widget build( BuildContext context ){  
    
    return Container(   
      width: double.infinity,
      height: 120,  
      alignment: Alignment.center,
      child: Text(
          widget.message,
          style: TextStyle( 
            fontSize: 17, 
            color: Color.fromRGBO(0, 0, 0, 0.425) 
          )
        )
    );
  
  }
 
}