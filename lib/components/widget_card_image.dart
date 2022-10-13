 
import 'package:appweb3603/components/widget_avatar.dart'; 
import 'package:flutter/material.dart'; 

class CardImage extends StatefulWidget{ 

  final String imageUrl;

  final double width;

  final double height;  

  final double? bottom;

  final double? top; 

  final bool? imageHttps;

  final Function onClick;

  final String? title;

  final String? subtitle;  

  CardImage( { Key? key, this.title, this.subtitle, this.imageHttps = true, required this.imageUrl, required this.onClick, required this.width, required this.height, this.top, this.bottom } ) : super( key : key );

  @override
  _CardImageState createState() => _CardImageState();
}

class _CardImageState extends State<CardImage>{ 

  @override 
  Widget build( BuildContext context ){

    double imageDimension = widget.width * 0.75;


    return InkWell(
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){ 
        widget.onClick();
      },
      child: 
      Container(   
        padding: EdgeInsets.all( 10 ),
        margin: EdgeInsets.only( 
          left: 5,
          right: 5, 
          top: widget.top ?? 5, 
          bottom: widget.bottom ?? 20 
        ),
        decoration: BoxDecoration( 
          color: Colors.white
        ),
        width:  widget.width,
        height: widget.height,
        child: Column( 
          children: [
            Container( 
              constraints: BoxConstraints( 
                maxWidth: imageDimension, 
                maxHeight: imageDimension, 
              ), 
              child: Avatar(avatar: widget.imageUrl, width: imageDimension, height: imageDimension )
            ), 
            Text( 
              widget.title ?? "", 
              style: TextStyle( 
                fontSize: 22, 
                fontWeight: FontWeight.w600, 
                overflow: TextOverflow.ellipsis,
              )
            ), 
            Text( 
              widget.subtitle ?? "", 
              style: TextStyle( 
                fontSize: 15, 
                fontWeight: FontWeight.w200, 
                overflow: TextOverflow.ellipsis,
              )
            ),  
          ]
        )
      )
    );
  }

}