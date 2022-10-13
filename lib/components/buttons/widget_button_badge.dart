import 'package:flutter/material.dart'; 

class ButtonBadge extends StatefulWidget{ 
 
  final Function callback; 

  final IconData? icon;

  final double? size;

  final Color? textColor;

  final Color? backColor; 

  final Color? iconColor;

  final EdgeInsets? margin;

  final int? count;

  final Color? borderColor;

  ButtonBadge({Key? key, this.borderColor, this.margin, this.icon, this.count, this.backColor, this.textColor, this.iconColor, this.size, required this.callback}) : super(key: key);

  @override
  ButtonBadgeState createState() => ButtonBadgeState();
}


class ButtonBadgeState extends State<ButtonBadge>{ 
  
 

  @override
  void initState(){ 
    super.initState(); 
  } 


  @override
  Widget build( BuildContext context ){ 
    return  InkWell(
      onTap: (){
        widget.callback();
      },
      child: Container(
        margin: widget.margin,
        child: Stack(
          children:[
            Icon(widget.icon, size: widget.size ?? 31, color: widget.iconColor ?? Colors.black),
            (widget.count!= null) 
              ?
                Positioned(
                  right: 0,
                  top: -1.0,
                  child: Container( 
                    width: 17.0,
                    height: 17.0,   
                    decoration: BoxDecoration( 
                      border: Border.all(
                        width: 1.3,
                        color: widget.borderColor ?? Colors.transparent
                      ),
                      color: widget.backColor ?? Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center( 
                      child: Text(
                        widget.count! < 100 ? widget.count!.toString() : '99+',
                        style: TextStyle(
                          fontSize: 6.7,
                          fontWeight: FontWeight.bold,
                          color: widget.textColor ?? Colors.black
                          )
                        )
                    ),
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