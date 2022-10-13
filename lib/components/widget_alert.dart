import 'package:appweb3603/components/buttons/widget_primary_button.dart';
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Alert extends StatefulWidget{

  final String? accessButtonText;

  final IconData? icon;
  
  final String message;

  final Function? accessButtonOnclick;

  final bool?  close;

  final Color? backgroundColor;

  final Color? borderColor; 

  Alert( { Key? key, this.borderColor, this.backgroundColor, this.close, this.accessButtonText, required this.message, this.icon, this.accessButtonOnclick  } ) : super( key : key );

  @override
  AlertState createState() => AlertState();

}

class AlertState extends State<Alert>{  

  bool _hide = false;
   
  @override
  void initState(){
    super.initState();   
  }

  @override
  Widget build( BuildContext context ){

    if( _hide ) return SizedBox.shrink();
      

    return Container(   
      margin: EdgeInsets.all(0),
      child: Stack( 
        children: [ 
          Container( 
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10), 
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              boxShadow: const [ ligthShadow ],
              color: widget.backgroundColor ?? primaryColorLigther, 
              borderRadius: BorderRadius.circular(5),  
              border: Border.all(width: 0.5, color: widget.borderColor ?? primaryColor)
            ),  
            child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [ 
                  Expanded( 
                    child: Container(
                      padding: EdgeInsets.all(6.5),
                      margin: EdgeInsets.only(left: 15, right: 5),
                      child: 
                        Text(
                          widget.message, 
                          maxLines: 2,
                          style: TextStyle( 
                            fontSize: 14.75, 
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                    )
                  ), 
                  ( widget.close == true ) 
                  ? 
                    PrimaryButton(
                      onClick: (){ 
                        if( !mounted ) return;
                        setState((){ 
                          _hide = true;
                        });
                      }, 
                      width: 35, 
                      height: 35, 
                      fontSize: 11,
                      icon: FontAwesomeIcons.xmark,
                      iconRight: true,
                      noBorder: true,
                      backgroundColor: Colors.transparent,
                      fontWeight: FontWeight.normal,
                      padding: noPadding,
                      onlyIcon: true,
                      textColor: primaryColor,
                    )
                  : 
                    SizedBox.shrink(),
                  ( widget.accessButtonOnclick != null ) 
                  ? 
                    PrimaryButton(
                      onClick: widget.accessButtonOnclick!, 
                      width: 130, 
                      height: 35, 
                      fontSize: 15,
                      icon: CupertinoIcons.arrow_right,
                      iconRight: true,
                      fontWeight: FontWeight.normal,
                      padding: noPadding,
                      title: widget.accessButtonText ?? "Acessar",
                    )
                  :
                    SizedBox.shrink()
                ]
              ), 
          ),
          ( widget.icon != null ) ? 
            Positioned( 
              top: 0, 
              left: 5,  
              child: Container(  
                alignment: Alignment.center,
                child: Container( 
                  width: 35, 
                  height: 35, 
                  decoration: BoxDecoration( 
                    color: Colors.white,  
                    borderRadius: BorderRadius.circular(100), 
                    border: Border.all(width: 0.5, color: primaryColor)
                  ), 
                  child: Icon( widget.icon! , size: 25, color: primaryColor)
                ) 
              ) 
            ) 
          :
            SizedBox.shrink()
        ]
      )
    );
  }

}