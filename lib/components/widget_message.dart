import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget{

  final String? text;

  final List<TextSpan>? textSpan;

  final Color? bgColor;

  final Color? textColor;

  final Color? iconColor;

  final double? iconSize;

  final IconData? icon;

  final bool noShadow;

  final bool? noBorder;

  final EdgeInsets? margin;

  final TextAlign? textAlign;

  final double? fontSize;
  
  final FontWeight? fontWeight;

  final EdgeInsets? padding;

  final double? borderRadius; 

  Message( { Key? key, this.noBorder, this.iconColor, this.iconSize, this.borderRadius, this.fontWeight, this.padding, this.fontSize, this.textAlign, this.margin, this.noShadow = false, this.icon, this.textSpan, this.bgColor, this.textColor, this.text }) : super( key : key );

  @override
  MessageState createState() => MessageState();
}


class MessageState extends State<Message>{  

  @override
  Widget build( BuildContext context ){  
    return Container(  
      width: double.infinity,
      decoration: BoxDecoration(  
        color: widget.bgColor ?? primaryColor,  
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),  
      ),
      margin: widget.margin ?? EdgeInsets.all( 0 ),
      padding: widget.padding ?? EdgeInsets.only( 
        top: 20, 
        bottom: 20, 
        left: 25, 
        right: 25
      ),
      child: Row( 
        children: [
          ( widget.icon != null )
            ? 
              Opacity(
                opacity: 0.64, 
                child: Container( 
                  margin: EdgeInsets.only( right: 20 ),
                  child: Icon( widget.icon, size: widget.iconSize ?? 24, color:widget.iconColor ?? Colors.white )
                )
              ) 
            :
              SizedBox.shrink()
          ,
          Expanded( 
            child: 
             ( widget.text != null )
              ?
                Text( 
                  widget.text!, 
                  softWrap: true,
                  textAlign: widget.textAlign,
                  style: TextStyle( 
                    fontSize: widget.fontSize ?? 17,
                    fontWeight: widget.fontWeight ?? FontWeight.normal,
                    color: widget.textColor ?? Colors.white,
                  )
                )
              :
                RichText( 
                  textAlign: widget.textAlign ?? TextAlign.start,
                  text: TextSpan(
                    style: TextStyle( 
                      fontSize: 17,
                      color: widget.textColor ?? Colors.white,
                    ), 
                    children: widget.textSpan!
                  )
                )
          )
        ] 
      ) 
    );
  }
}