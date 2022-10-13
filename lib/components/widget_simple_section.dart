import 'package:flutter/material.dart'; 

class SimpleSection extends StatefulWidget{ 

  final String title;

  final List<Widget> children;

  final double? titleSize;

  final Color? titleColor;

  final EdgeInsets? margin;
  
  SimpleSection( { Key? key, this.margin, this.titleColor, this.titleSize, required this.title, required this.children } ) : super( key : key );

  @override
  SimpleSectionState createState() => SimpleSectionState();

}

class SimpleSectionState extends State<SimpleSection>{ 
  
  @override
  Widget build( BuildContext context ){
    return Container(
      width: double.infinity, 
      margin: widget.margin ?? EdgeInsets.all( 0 ),
      child: Column( 
        children: [
          Container(
            padding: EdgeInsets.all( 10 ),
            alignment: Alignment.bottomLeft, 
            child: Text(
              widget.title, 
              softWrap: true, 
              maxLines: 5, 
              style: TextStyle( 
                fontSize: widget.titleSize ?? 16, 
                fontWeight: FontWeight.bold, 
                overflow: TextOverflow.ellipsis, 
                color: widget.titleColor ?? Colors.black
              )
            )
          ),
          Column( 
            children: widget.children
          ) 
        ]
      )
    );

  }

}