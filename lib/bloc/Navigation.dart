import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Navigation { 
   

  static void viewPost( context, post){ 
    navigatorPushNamed(context, '/view-post', arguments: 
      {
        'post': post, 
        'currentUser': Modular.get<Controller>().currentUser
      }  
   ); 
  }

  static void changeToSecurity(context){
    navigatorPushNamed(context, '/view-security'); 
  }

  static void changeToInitPage(context){
    navigatorPushNamed(context, '/'); 
  }

  static void changeToMaps (context){
    navigatorPushNamed(context, '/view-maps'); 
  }

  static void changeToFeed(context){
    navigatorPushNamed(context, '/view-home'); 
  }

  static void changeToMain(context){
    navigatorPushNamed(context, '/view-main'); 
  }

  static void changeToSearchEvent(context){
    // Necessário fazer o logout do usuário
    Modular.get<Controller>().logout();

    navigatorPushNamed(context, '/view-search-event'); 
  }

  static void changeToEditProfile(context){  
    navigatorPushNamed(context, '/view-profile'); 
  }

  static void changeToFiles(context){  
    navigatorPushNamed(context, '/view-files'); 
  }

  static void changeToBack(context){  
    if(Navigator.maybeOf(context) != null) Navigator.maybeOf(context)?.pop();
  }

  static void changeToTransmissions(context){  
    navigatorPushNamed(context, '/view-transmissions'); 
  }

  static void changeToLiveTransmission(context){  
    navigatorPushNamed(context, '/view-transmission-live'); 
  }

  static void changeToLinks(context){  
    navigatorPushNamed(context, '/view-links'); 
  }

  static void changeToHome(context){ 
    navigatorPushNamed(context, '/view-home'); 
  }

  static void changeToSchedules(context){ 
    navigatorPushNamed(context, '/view-schedules'); 
  }

  static void changeToMySchedules(context){ 
    navigatorPushNamed(context, '/view-my-schedules'); 
  }

   static void changeToParticipants(context){ 
    navigatorPushNamed(context, '/view-participants'); 
  }


  static void changeToSchedule(context, Map<String, dynamic> arguments){ 
    navigatorPushNamed(context, '/view-schedule', arguments : arguments); 
  }

  static void changeToGaleria( context){ 
    navigatorPushNamed(context, '/view-photos'); 
  }

  static void changeToSpeakers( context){ 
    navigatorPushNamed(context, '/view-speakers'); 
  }

}