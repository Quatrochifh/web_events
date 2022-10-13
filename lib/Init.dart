import 'dart:async';

import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/bloc/Account.dart';
import 'package:appweb3603/bloc/Bloc.dart';
import 'package:appweb3603/bloc/Event.dart' as event_bloc;
import 'package:appweb3603/bloc/Post.dart';
import 'package:appweb3603/conf.dart';
import 'package:appweb3603/core/Auth.dart';
import 'package:appweb3603/core/Controller.dart';
import 'package:appweb3603/db/NotificationDB.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/objects/object_firebase.dart';
import 'package:appweb3603/services/ContactService.dart';
import 'package:appweb3603/services/EventService.dart';
import 'package:appweb3603/services/PostService.dart';
import 'package:appweb3603/services/UserService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Init extends Bloc{

  int _countCheckStatus = 0;

  dynamic _context;

  Init ({dynamic context}) : _context = context, super();

  void debug() {
    debugPrint( "Server Url: $serverUrl");
    debugPrint( "Server Https: ${(serverHttps == true? "Sim" : "Não")}");
  }

  /*
   * Checa se o usuário está logado, e carregará esses dados
  */
  Future<dynamic> _checkUserDataStatus() async {
    _countCheckStatus +=  1;
    return Future.delayed(Duration(seconds: 1), (){
      if(Modular.get<Controller>().currentUser.id > 1){
        // Evento atual
        this.diContainer.set(Event, Modular.get<Controller>().currentEvent);
        // Usuário atual
        this.diContainer.set(User, Modular.get<Controller>().currentUser);
        return true;
      }else{
        if(_countCheckStatus < 6){
          return _checkUserDataStatus();
        } else {
          return false;
        }
      }
    }); 
  }

  /*
   * Init. Aqui injetamos as dependências (Services, Actions do Componente ... ) numa classe independente.
  */
  void init() async {

    /*
     * Carregando as dependências que usaremos no decorrer do app
    */
  
    /*
     * SERVIÇOS
    */
    this.diContainer.set(UserService, new UserService());
    this.diContainer.set(EventService, new EventService());
    this.diContainer.set(PostService, new PostService());
    this.diContainer.set(ContactService, new ContactService());

    /*
     * DB
    */
    this.diContainer.set(NotificationDB, new NotificationDB());

    /*
     * CORE
    */
    this.diContainer.set(Auth, new Auth());
    this.diContainer.set(Controller, new Controller());

    /*
     * Checa se o usuário está logado, e carregará esses dados
    */
    bool userLogged = await _checkUserDataStatus();

    /*
     * Firebase
    */
    if (userLogged == true) {
      OBFirebase obFirebase = new OBFirebase(context: this._context);
      await obFirebase.setUpFirebaseNotifications();
      updateUserFirebaseToken(obFirebase.firebaseToken);
    }

    /*
     * BLOCS
    */
    this.diContainer.set(Account, new Account());
    this.diContainer.set(Post, new Post());
    this.diContainer.set(event_bloc.Event, new event_bloc.Event());



    if (userLogged) {
      debugPrint("Usuário  logado!");
      Modular.to.navigate('/view-main');
    } else {
      debugPrint("Usuário não logado!");
      Modular.to.navigate('/view-search-event');
    }
  }



  /*
   * Checa se o firebaseToken do usuário mudou. 
   * Se sim, chamamos o UserService para poder atualizar a coluna na base
  */
  void updateUserFirebaseToken(String? currentFirebaseToken) {
    User currentUser = globalDIContainer.get(User) as User;
    if (currentUser.firebaseToken != currentFirebaseToken) {
      UserService userService = globalDIContainer.get(UserService) as UserService;
      userService.updateFirebaseToken(currentFirebaseToken!)!.then((results){
        if (results != true) {
          debugPrint("Falha ao atualizar firebaseToken do usuário. Erro: $results");
        }
      });
    }
  }


  static cleanControllerData()
  {
    Modular.get<Controller>().cleanAll();
  }
}