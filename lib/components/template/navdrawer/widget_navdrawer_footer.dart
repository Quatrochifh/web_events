
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/style.dart';  
import 'package:flutter/material.dart';

import '../../../entities/Event.dart';
 

class NavDrawerFooter extends StatefulWidget{  

  final Event event;

  NavDrawerFooter({Key? key, required this.event}) : super(key: key);

  @override
  NavDrawerFooterState createState() => NavDrawerFooterState();
  
}
 

class NavDrawerFooterState extends State<NavDrawerFooter>{ 

  @override
  Widget build( BuildContext context ){
    return  Container(
      height: 50,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: noMargin,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [  
            CustomImage(
              image: "assets/images/logo_principal.png",
              local: true,
              width: 70,
              height: 30,
              fit: BoxFit.contain,
            ),
          ],
        ),
      )
    );
  }

}