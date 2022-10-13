import 'package:flutter/material.dart'; 

class Label extends StatefulWidget{  

  final String? text;

  final Color? bgColor;

  final Color? textColor;

  final Color? iconColor;

  final double? iconSize;

  final IconData? icon; 

  final EdgeInsets? margin;

  final TextAlign? textAlign;

  final double? fontSize;
  
  final FontWeight? fontWeight;

  final EdgeInsets? padding;

  final double? borderRadius; 

  Label(  this.text, { Key? key, this.iconColor, this.iconSize, this.borderRadius, this.fontWeight, this.padding, this.fontSize, this.textAlign, this.margin, this.icon, this.bgColor, this.textColor }) : super( key : key );

  @override
  LabelState createState() => LabelState();
}


class LabelState extends State<Label>{  

  @override
  Widget build( BuildContext context ){  
    return Container(  
      width: double.infinity,
      decoration: BoxDecoration(  
        color: widget.bgColor ?? Colors.transparent, 
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 30) 
      ),
      margin: widget.margin ?? EdgeInsets.all( 0 ),
      padding: widget.padding ?? EdgeInsets.only( 
        top: 2.5, 
        bottom: 2.5, 
        left: 10, 
        right: 10
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
                    fontSize: widget.fontSize ?? 13,
                    fontWeight: widget.fontWeight ?? FontWeight.bold,
                    color: widget.textColor ?? Colors.grey,
                  )
                )
              :
                SizedBox.shrink()
          )
        ] 
      ) 
    );
  }
}