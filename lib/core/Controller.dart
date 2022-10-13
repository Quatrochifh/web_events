import 'package:appweb3603/Init.dart';
import 'package:appweb3603/core/Auth.dart';
import 'package:appweb3603/core/DIContainer.dart';
import 'package:appweb3603/db/DB.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Controller {

  Auth _auth = new Auth();

  DIContainer _diContainer = new DIContainer();

  User? _currentUser;

  Event? _currentEvent;

  String? _error;

  Controller(){
    this.updateUserData();
  }

  /*
    @Return (DIContainer)
  */

  DIContainer get diContainer => this._diContainer;

  /*
    @Return (DB) db : Objeto do Banco de Dados SQLLite
  */

  DB get db => new DB();

  /*
    @Return (Auth) auth : Objeto do usuário autenticado ja instanciado.
  */
  Auth get auth =>  this._auth;

  /*
    @Return (Future)  : Objeto do User 
  */
  Future get user  => this.auth.getUserSession().then((response){ 
    if(response != null) return response['user_data']; 
    return null;
  });

   /*
    @Return (Future)  : Objeto do User 
  */
  Future get event  => this.auth.getUserSession().then((response){ 
    if(response != null) return response['event_data']; 
    return null;
  });

  User get currentUser => this._currentUser ?? new User();

  Event get currentEvent => this._currentEvent ?? new Event();


  /*
    @Param (BuildContext) context : Quando tal tela necessitar da autenticação do usuário.
  */
  void requireAuthentication(context){ 
    this._auth.hasConnected().then((results) { 
      if(results == true){ 
      }else{
        //Login Screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Init init = new Init();
          init.init();
        });
      } 
    });  
  }

  Future<dynamic> logout(){ 
    return this._auth.hasConnected().then((results) { 
      if(results == true){ 
        return this._auth.logout();
      }
    });
  }

  /*
  * Vamos atualizar os dados do usuário
  */
  Future<dynamic> updateUserData() async {
    await this._auth.hasConnected().then((results) {
      if(results == true){
        user.then((results) {
          _currentUser = results;
        }); 
        event.then((results) { 
          _currentEvent = results;
        });
      }
    });
  }

  void afterLogin() async {
    this.updateUserData().then((results){
      Modular.to.navigate('/');
    });
  }

  void registerError(String error) {
    this._error = error;
  }

  void setDiContainer(DIContainer diContainer) {
    _diContainer = diContainer;
  }

  String? getError() {
    String error = this._error ?? "";

    this._error = null;

    return error;
  }

  void cleanAll()
  {
    this._currentUser = null;
    this._currentEvent = null;
    diContainer.update(User, new User());
    diContainer.update(Event, new Event());

    debugPrint("Limpando os dados do controller, User e Event no diContainer");
  }

}