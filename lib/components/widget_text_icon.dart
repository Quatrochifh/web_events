import 'package:flutter/material.dart'; 

class TextIcon extends StatelessWidget{ 

  final String? text; 

  final IconData? icon; 

  final double? size;

  final Color? color;

  final Color? iconColor;

  final double? iconMargin;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  TextIcon({ Key? key, this.iconMargin, this.iconColor, this.margin, this.padding, this.text, this.icon, this.size, this.color }) : super( key : key );

  @override
  Widget build(BuildContext context){
    return Container(
      padding: padding,
      margin: margin ?? EdgeInsets.only(right: 6.0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, 
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [  
          ( icon != null ) 
            ?
              Container( 
                margin: EdgeInsets.only(right: iconMargin ?? 13),
                child: Icon( icon, size: size ?? 15, color: (iconColor ?? color) ?? Colors.black  )
              )
            :
              SizedBox.shrink(), 
            Text( text ?? "", style: TextStyle( fontSize: size ?? 15, color: color ?? Colors.black ) )
        ],
      )
    );
  }

}