import 'package:flutter/material.dart'; 

class Badge extends StatelessWidget{ 

  final String? text;
  
  final double? size;

  final Color? textColor;

  final FontWeight? fontWeight;

  final Color? bgColor;

  final Color? borderColor;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final double? borderRadius;

  final IconData? icon;

  final double? width;

  final double? height;

  final double? opacity;

  Badge({
    Key? key,
    this.borderColor,
    this.fontWeight,
    this.opacity = 1,
    this.height,
    this.width,
    this.icon,
    this.borderRadius,
    this.text,
    this.padding,
    this.margin,
    this.size,
    this.textColor,
    this.bgColor
  }) : super(key: key); 

  @override 
  Widget build( BuildContext context ){


    return Container( 
      width: width,
      height: height,
      alignment: Alignment.center,
      padding: padding ?? EdgeInsets.only(
        bottom: 6,
        top: 6,
        left: 12,
        right: 12
      ),
      margin: margin ?? EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.black.withOpacity(0.1),
          width: 0.5
        ),
        color: bgColor ?? Colors.white.withOpacity(opacity!),
        borderRadius: BorderRadius.circular( borderRadius ?? 5 )
      ),
      child: Container( 
        alignment: Alignment.center,
        child:  
          Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              ( icon != null ) ? 
                Container( 
                  margin: EdgeInsets.only(right: text != null ? 10 : 0 ),
                  child: Icon( icon!, color: textColor ?? Colors.black, size: size ?? 13 )
                )
              :
                SizedBox.shrink(),
              ( text != null ) ? 
                Text( 
                  text! , 
                  softWrap: true,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: fontWeight ?? FontWeight.normal,
                    fontSize: size ?? 13, 
                    color: textColor ?? Colors.black, 
                    overflow: TextOverflow.ellipsis,
                  )
                )
              :
                SizedBox.shrink()
            ]
          )
      )
    );
  }

}