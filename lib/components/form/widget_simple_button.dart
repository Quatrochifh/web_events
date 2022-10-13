import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart'; 

class SimpleButton extends StatefulWidget{ 

  final String? title;

  final IconData? icon;

  final double? width; 
  
  final double? height;
  
  final EdgeInsets? padding;

  final double? iconSize;

  final double? textSize;

  final Color? iconColor;

  final Function onClick; 

  final int? badgeCount;

  final bool? directionBottom;

  SimpleButton({Key? key, this.width, this.height, this.directionBottom = true, this.badgeCount, required this.onClick, this.iconColor, this.iconSize, this.textSize, this.title, this.icon, this.padding}) : super(key: key);

  @override
  SimpleButtonState createState() => SimpleButtonState();

}

class SimpleButtonState extends State<SimpleButton>{
  
  bool _current = false;

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
        bottom: 6, 
        top: 6, 
        left: 1,
        right: 1
      );
    }
  }

  void currentButton(bool current){  
    if(!mounted) return;  
    
    setState((){ 
      _current = current;
    });
  }

  @override 
  Widget build(BuildContext context){  

    return InkWell(
      onTap: (){ 
        widget.onClick();
      },
      child: 
        Container( 
          width: widget.width, 
          padding: padding,
          height: widget.height ?? double.infinity,
          decoration: BoxDecoration( 
            color: _current ? Colors.transparent : Colors.transparent, 
            border: Border(
              top: BorderSide(
                width: 5,
                color: _current ? primaryColor: Colors.transparent
              )
            )
          ),
          child: Stack(  
              alignment: AlignmentDirectional.center,
              children: [
                Container( 
                  height: 50,
                  color: Colors.transparent,
                  child: Column( 
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                      widget.icon != null ? 
                        Expanded( 
                          flex: 3, 
                          child: Container( 
                            color: Colors.transparent,
                            margin: EdgeInsets.only(
                              bottom: (widget.title != null && widget.directionBottom == true ? 15.5 : 0)
                            ),
                            child: Icon( 
                              widget.icon, 
                              size: widget.iconSize ?? 33, 
                              color: _current ? primaryColor : (widget.iconColor ?? Colors.black.withOpacity(0.45).withOpacity(0.6).withOpacity(0.7)),
                              textDirection: TextDirection.ltr
                            ) 
                          )
                        ) 
                      : 
                        SizedBox.shrink(), 
                      widget.title != null ?  
                        Expanded(
                          flex: 2, 
                          child: Text(
                            widget.title ?? "", 
                            style: TextStyle( 
                              fontSize: widget.textSize ?? 13,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color:  _current ? primaryColor : Colors.black.withOpacity(0.45).withOpacity(0.6).withOpacity(0.7),  
                            )
                          )
                        )
                      : 
                        SizedBox.shrink()
                    ]
                  ),
                ),
                ( widget.badgeCount != null ) ?
                  Positioned( 
                    top: 6,
                    right: 2,
                    child: Container( 
                      alignment: Alignment.center,
                      width: 16, 
                      height: 16, 
                      decoration: BoxDecoration( 
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(100), 
                        boxShadow: [ 
                          BoxShadow(
                            color: Colors.black.withOpacity(0.45).withOpacity(0.6).withOpacity(0.7).withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(1, 1), 
                          )
                        ]
                      ),
                      child: Text( 
                        ( widget.badgeCount! < 10 ) ? widget.badgeCount.toString() : "+9", 
                        maxLines: 1, 
                        style: TextStyle( 
                          color: Colors.black.withOpacity(0.45).withOpacity(0.6).withOpacity(0.7), 
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis
                        )
                      )
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