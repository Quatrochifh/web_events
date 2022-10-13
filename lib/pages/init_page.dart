 
import 'dart:async';
import 'package:appweb3603/Init.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_loading_block.dart';
import 'package:appweb3603/conf.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:flutter/material.dart';

import '../bloc/Login.dart';
import '../entities/Event.dart';

class InitPage extends StatefulWidget{ 

  final String? startFeed;

  InitPage({Key? key, this.startFeed}) : super(key: key);

  @override
  InitPageState createState() => new InitPageState();
} 

class InitPageState extends State<InitPage> with PageComponent {   

  Timer? _timer;

  Init? init;

  Login login = new Login();

  Event? currentEvent;

  @override 
  void initState(){
    super.initState();

    this.init = Init(context: context);
    init!.init();

    Future.delayed(Duration(milliseconds: 25), (){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        login.fetchCurrentEvent().then((results){
          setState((){
            currentEvent = results;
          });
        });
      });
    });
  }
  
   

  @override
  Widget build(BuildContext context){

    return content(
      color: Colors.white,
      padding: EdgeInsets.all(0), 
      body:  <Widget>[  
        Expanded( 
          flex: 6, 
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: 
                  currentEvent != null
                  ?
                    CustomImage(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      image: currentEvent!.background,
                    )
                  :
                    SizedBox.shrink()
              ),
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: LoadingBlock(
                          transparent: true,
                          text: "Carregando...",
                          textColor: Colors.grey.withOpacity(0.655)
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0)
                        ),
                        child: SafeArea(
                          top: false,
                          child: Text(
                            "Versão $appVersion",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                            ),
                          )
                        )
                      )
                    ]
                  )
                )
              )
            ]
          )
        )
      ],
      header: SizedBox.shrink(), 
      showFooter: false
    );  
 
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }
} 

