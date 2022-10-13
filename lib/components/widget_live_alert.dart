import 'package:appweb3603/components/buttons/widget_primary_button.dart'; 
import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LiveAlert extends StatefulWidget{ 

  final Function? onClick; 

  LiveAlert( { Key? key, this.onClick  } ) : super( key : key );

  @override
  LiveAlertState createState() => LiveAlertState();

}

class LiveAlertState extends State<LiveAlert>{  

  bool _hide = false;
   
  @override
  void initState(){
    super.initState();   
  }

  @override
  Widget build( BuildContext context ){

    if( _hide ) return SizedBox.shrink(); 

    return Container(  
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10), 
      width: MediaQuery.of(context).size.width - 20,
      height: 65,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: const [ darkShadowOffsetY35 ],
        color: Colors.white, 
        image:  new DecorationImage( 
          image: AssetImage('assets/images/background/background_points_cinza.png')
        ),
        borderRadius: BorderRadius.circular(10),  
        border: Border.all(
          width: 0.5, 
          color: Color.fromRGBO(0, 0, 0, 0.075)
        )
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
                    "Tá rolando live!",
                    maxLines: 2,
                    style: TextStyle( 
                      fontSize: 14.75, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
              )
            ),   
            ( widget.onClick != null ) 
            ? 
              PrimaryButton(
                onClick: widget.onClick!, 
                width: 35, 
                height: 35, 
                fontSize: 15,
                backgroundColor: Colors.transparent,
                icon: CupertinoIcons.play, 
                fontWeight: FontWeight.normal,
                padding: noPadding,
                textColor: primaryColor,
                onlyIcon: true,
              )
            :
              SizedBox.shrink(), 
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
            ),
          ]
        ), 
    );
  }

}