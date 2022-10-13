import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget{ 

  final String? title;

  final IconData? icon;
  
  final EdgeInsets? padding;

  final double? iconSize;

  final bool? onlyBorder; 

  final bool? noBorder; 

  final bool? onlyIcon; 

  final bool? noTapBorder; 

  final bool? iconRight; 

  final Function onClick; 

  final double? width;

  final double? height;

  final double? fontSize;

  final double? marginTop;

  final double? marginBottom;

  final double? marginRight;

  final double? marginLeft;

  final double? borderRadius;

  final FontWeight? fontWeight;

  final Color? backgroundColor;

  final Color? borderColor;

  final Color? textColor; 

  final Color? iconColor; 

  final bool? shadow;

  final MainAxisAlignment? mainAxisAlignment;

  final int? style;

  final bool? degrade;

  final EdgeInsets? iconMargin;

  PrimaryButton({Key? key,
  this.iconMargin,
  this.iconColor,
  this.degrade = false,
  this.style = 0,
  this.mainAxisAlignment,
  this.borderColor,
  this.shadow,
  this.noTapBorder,
  this.iconRight,
  this.noBorder,
  this.onlyIcon,
  this.textColor,
  this.backgroundColor,
  this.height,
  this.fontWeight,
  this.borderRadius,
  this.marginTop,
  this.marginRight,
  this.marginLeft,
  this.marginBottom,
  this.fontSize,
  required this.onClick,
  this.onlyBorder = false,
  this.width,
  this.iconSize,
  this.title,
  this.icon,
  this.padding
  }) : super(key: key);

  @override
  PrimaryButtonState createState() => PrimaryButtonState();

}

class PrimaryButtonState extends State<PrimaryButton>{

  bool _tapped = false;

  EdgeInsets padding = EdgeInsets.only( 
    bottom: 0, 
    top: 0, 
    left: 0, 
    right: 0 
  );
    
  @override 
  void initState(){
    super.initState();
    if( widget.padding != null ){
      padding = widget.padding!;
    } else {
      padding = EdgeInsets.only( 
        bottom: 5, 
        top: 5, 
        left: 10, 
        right: 10 
      );
    }
  }

  void _clickAction() {

    if(!mounted) return;
    
    setState(() {   
      widget.onClick();   
      _tapped = true; 
    });

    Future.delayed(Duration( seconds: 1 ), (){ 

      if( !mounted ) return;
      
      setState((){ 
        _tapped = false; 
      }); 
    });
  }

  @override 
  Widget build( BuildContext context ){

    BoxDecoration iconDecoration = BoxDecoration();

    return 
    Container(  
      margin: EdgeInsets.only( 
        top: widget.marginTop ?? 0, 
        bottom: widget.marginBottom ?? 0,  
        right: widget.marginRight ?? 0,
        left: widget.marginLeft ?? 0,
      ), 
      decoration: BoxDecoration(   
        border: Border.all( 
          width:  2.0, 
          color:  _tapped == false || widget.noTapBorder == true  ? Colors.transparent : primaryColorLigther
        ), 
        borderRadius: BorderRadius.circular( widget.borderRadius != null ? widget.borderRadius! * 1.03 : 2), 
        boxShadow: widget.shadow != true ? null : [
          BoxShadow(
            color: Colors.black.withOpacity(0.125),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(1, 1), 
          ),
        ]
      ),
      clipBehavior: Clip.antiAlias,
      child:
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: (){ 
            _clickAction(); 
          }, 
          child: 
            Container(  
              width: widget.width ?? double.infinity,
              height: widget.height ?? 55,
              decoration: BoxDecoration( 
                color: widget.onlyBorder == true ? widget.backgroundColor ?? Colors.transparent : widget.backgroundColor ?? primaryColor,
                border: Border.all( width: 0.6, color: widget.onlyBorder == true && widget.noBorder != true ? widget.borderColor ?? primaryColor : Colors.transparent ),
                borderRadius: BorderRadius.circular( widget.borderRadius ?? 1)
              ),
              child: Row( 
                mainAxisAlignment: widget.mainAxisAlignment ?? (widget.iconRight != true ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ 
                  widget.icon != null && widget.iconRight != true ? 
                    Container(
                      decoration: iconDecoration,
                      width: widget.iconSize ?? 23,
                      height: widget.iconSize ?? 23,
                      margin: widget.iconMargin ?? EdgeInsets.only(right: ( widget.title != null && widget.onlyIcon != true ? 10.5 : 0 ) ),
                      child: Icon( 
                        widget.icon,
                        size: widget.iconSize ?? 23,
                        color: widget.onlyBorder == true ? ( widget.iconColor ?? (widget.textColor ?? primaryColor) ) : ( ( widget.iconColor ?? (widget.textColor ?? Colors.white) ) ) 
                      ) 
                    )
                  : 
                    SizedBox.shrink(), 
                  widget.title != null && widget.onlyIcon != true ? 
                    Container(
                      padding:  padding,
                      child: Text(
                        widget.title ?? "",  
                        style: TextStyle (
                          fontSize: widget.fontSize ?? 15, 
                          overflow: TextOverflow.ellipsis,  
                          color: widget.onlyBorder == true ? ( widget.textColor ?? primaryColor )  : ( widget.textColor ?? Colors.white ),
                          fontWeight: widget.fontWeight ?? FontWeight.normal,
                        )
                      )
                    )
                  : 
                    SizedBox.shrink(),
                  widget.icon != null && widget.iconRight == true ? 
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Icon( 
                        widget.icon, 
                        size: widget.iconSize ?? 23, 
                        color: widget.onlyBorder == true ? ( widget.textColor ?? primaryColor ) : ( widget.textColor ?? Colors.white ) 
                      ) 
                    )
                  : 
                    SizedBox.shrink(), 
                ]
              )
            )
          )
    ); 
  }
}