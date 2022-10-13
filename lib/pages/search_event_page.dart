import 'dart:async';

import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/bloc/Login.dart';
import 'package:appweb3603/components/forms/sarch_event_form.dart';
import 'package:appweb3603/components/widget_custom_image.dart';
import 'package:appweb3603/components/widget_event_preview.dart';
import 'package:appweb3603/style.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/pages/page_component.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_modular/flutter_modular.dart';

class SearchEvent extends StatefulWidget{ 

  SearchEvent({Key? key}) : super(key: key);

  @override
  SearchEventState createState() => new SearchEventState();
} 

class SearchEventState extends State<SearchEvent> with PageComponent {  

  Timer? _timer;

  List<Widget> _eventsWidgets = [];

  @override 
  void initState(){
    super.initState();
  
    this._fetchLogins();
  }

  void _fetchLogins() {
    Modular.get<Login>().fetchEventsLogin().then((results){

      if (results.isEmpty) return;

      for (int i = 0; i < results.length; i++) {

        if(results[i.toString()] == null || results[i.toString()]['event'] == null) continue;

        Event eventLogin = Event.fromJson(results[i.toString()]['event']);

        _eventsWidgets.add(
          EventPreview(
            hideInfo: true,
            event: eventLogin,
            onClick: (){ 
              navigatorPushNamed(
                context, '/view-login', 
                arguments: {
                  'eventCode': eventLogin.code,
                  'eventName': eventLogin.title,
                  'eventLogo': eventLogin.logo,
                  'eventBackground': eventLogin.background,
                  'loginEmail' : results[i.toString()]['email'],
                  'loginPassword' : results[i.toString()]['password'],
                }
              );
            }, 
          )
        );
      }

      if (_eventsWidgets.isNotEmpty) {
        showFloatScreen(
          title: "Logins recentes",
          child: Column(children: _eventsWidgets)
        );
      }
    });
  }

  /*
   * Buscar por um evento pelo seu
   * Código ou nome
  */
  void _searchEvent(String value){   
    navigatorPushNamed(context, '/view-search-event-results', arguments: {'searchValue': value}); 
  }

  @override
  Widget build( BuildContext context ){ 
    
    return WillPopScope( 
      onWillPop: () { 
        //Vamos bloquear a opção de "voltar"
        return Future.value(false); 
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () { 
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(  
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: appPrimaryColor,
              image:  new DecorationImage(
                image: AssetImage('assets/images/background/search_event_page_background.png')
              ) 
            ),
            child: 
              Stack( 
                children: [ 
                  Column( 
                    children: [ 
                      Expanded( 
                        child: Column(
                          children:[
                            SafeArea(
                              top: false,
                              bottom: false,
                              child: Container(  
                                margin: EdgeInsets.only(
                                  bottom:30,
                                  top: 85
                                ), 
                                alignment: Alignment.center,
                                child: CustomImage(
                                  width: 200, 
                                  height: 80, 
                                  fit: BoxFit.contain, 
                                  local: true, 
                                  image: appLogoPrincipalBranco
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: SafeArea(
                                bottom: true,
                                top: false,
                                child: SearchEventForm(
                                  feedback: _searchEvent,
                                  cancelOnclick: (){ 
                                    if (_eventsWidgets.isNotEmpty) {
                                      showFloatScreen(
                                        title: "Logins recentes",
                                        child: Column(children: _eventsWidgets)
                                      );
                                    }
                                  }
                                )
                              )
                            ),
                            // Eventos já acessados
                            Container(

                            )
                          ]  
                        ), 
                      )
                    ],
                  ),
                  alertComponent(),
                  loadingComponent(),
                  floatScreenComponent()
                ],
              ) 
            )
          )   
        )
      );
  }

  @override
  void dispose(){ 
    if( _timer != null ) _timer!.cancel();
    super.dispose();
  }

}  