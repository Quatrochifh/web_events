 
import 'dart:async';

import 'package:appweb3603/components/template/navdrawer/widget_navdrawer.dart';
import 'package:appweb3603/components/template/widget_template_header.dart'; 
import 'package:appweb3603/core/Controller.dart';  
import 'package:appweb3603/pages/page_component.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'; 

class ErrorPage extends StatefulWidget{ 

  final String? startFeed;

  ErrorPage( { Key? key, this.startFeed } ) : super( key : key );

  @override
  ErrorPageState createState() => new ErrorPageState();
} 

class ErrorPageState extends State<ErrorPage> with PageComponent {   

  Timer? _timer;

  @override 
  void initState(){
    super.initState();   
  }   

  @override
  Widget build( BuildContext context ){ 

    /*
      Vamos requerer a autenticação.
    */
    Modular.get<Controller>().requireAuthentication( context ); 

    return content(
      padding: EdgeInsets.all(0), 
      body:  <Widget>[  
        Expanded( 
          flex: 6, 
          child: Text("Houve um erro.")
        )
      ], 
      drawer: NavDrawer(),
      header: TemplateAppBar(event:  Modular.get<Controller>().currentEvent, user:  Modular.get<Controller>().currentUser ) 
    );  
 
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }
} 

