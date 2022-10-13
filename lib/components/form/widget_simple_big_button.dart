import 'package:appweb3603/style.dart';
import 'package:flutter/material.dart'; 

class SimpleBigButton extends StatefulWidget{ 

  final String? title;

  final IconData? icon; 

  final double? iconSize;

  final double? textSize; 

  final Function onClick; 

  final int? badgeCount; 

  SimpleBigButton( { Key? key, required this.onClick, this.badgeCount, this.iconSize, this.textSize, this.title, this.icon } ) : super( key : key );

  @override
  SimpleBigButtonState createState() => SimpleBigButtonState();

}

class SimpleBigButtonState extends State<SimpleBigButton>{ 
  bool _current = false;

  void currentButton( bool current ){  
    if(!mounted) return;  
    
    setState((){ 
      _current = current;
    });
  }

  @override 
  void initState(){
    super.initState(); 
  }

  @override 
  Widget build( BuildContext context ){  

    return InkWell(
      onTap: (){ 
        widget.onClick();
      },
      child: 
        Container( 
          width: 150, 
          height: 150,
          decoration: BoxDecoration( 
            color: Colors.transparent,  
            border: Border( top: BorderSide( width: 5, color: _current  ? primaryColor : Colors.transparent ) )
          ),
          child: Stack( 
            children: [ 
              Container(
                color: Colors.transparent, 
                alignment: Alignment.center,
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ 
                    widget.icon != null ? 
                      Container( 
                        margin: EdgeInsets.only( bottom: ( widget.title != null ? 16.5 : 0 ) ),
                        child: Icon( 
                          widget.icon, 
                          size: widget.iconSize ?? 23, 
                          color: primaryColor
                        ) 
                      )
                    : 
                      SizedBox.shrink(), 
                    widget.title != null ? 
                      Text(  
                        widget.title ?? "", 
                        style: TextStyle(  
                          fontSize: widget.textSize ?? 13, 
                          overflow: TextOverflow.ellipsis,  
                          color: primaryColor, 
                          fontWeight: FontWeight.bold
                        ), 
                        textAlign: TextAlign.center,
                      )
                    : 
                      SizedBox.shrink()
                  ]
                ),  
              ),
              ( widget.badgeCount != null ) ?
                Positioned( 
                  top: 10,
                  right: 10,
                  child: Container( 
                    alignment: Alignment.center,
                    width: 25, 
                    height: 25, 
                    decoration: BoxDecoration( 
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all( width: 0.5, color: primaryColor )
                    ),
                    child: Text( 
                      ( widget.badgeCount! < 10 ) ? widget.badgeCount.toString() : "+9", 
                      maxLines: 1, 
                      style: TextStyle( 
                        color: Colors.white, 
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