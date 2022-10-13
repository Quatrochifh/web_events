import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 

class PagePositioned extends StatefulWidget{

  final Widget child;

  final double? bottom;

  final Alignment? alignment;

  PagePositioned({Key? key, this.alignment, this.bottom, required this.child }) : super(key : key); 

  @override
  PagePositionedState createState() => new PagePositionedState();
}

class PagePositionedState extends State<PagePositioned>{
  @override 
  Widget build( BuildContext context ){
    return 
      Positioned( 
        top: 0, 
        left: 0, 
        bottom: widget.bottom,
        child:  Container(
          alignment: widget.alignment ?? Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height, 
          decoration: BoxDecoration( 
            color: Color.fromRGBO(0, 0, 0, 0.67) 
          ),
          child: widget.child
        )
      );
         
  
  }
 
}