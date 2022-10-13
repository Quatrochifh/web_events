import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class Slide extends StatefulWidget{ 

  final double? height;

  final List<Widget> children;  

  final double? ratio;

  final bool? itemExtent;

  final EdgeInsets? padding;

  Slide({Key? key, this.padding, this.height, this.itemExtent, required this.children, this.ratio}) : super( key : key );

  @override
  SlideState createState() => SlideState();
}

class SlideState extends State<Slide>{ 

  @override
  void initState(){
    super.initState(); 
  }

  @override
  Widget build( BuildContext context ){ 

    return Container(
      margin: EdgeInsets.only(top: ( widget.height ?? 0 ) * 0.01 , bottom:  ( widget.height ?? 0 ) * 0.01 ), 
      width: double.infinity,
      height: widget.height ?? 300, 
      child: ListView(
        padding: widget.padding ?? noPadding,
        scrollDirection: Axis.horizontal,
        itemExtent: widget.itemExtent == true ? MediaQuery.of(context).size.width * (widget.ratio ?? 0.5) : null,
        children: widget.children
      )
    );
  }


  @override
  void dispose(){  
    super.dispose();
  }
}