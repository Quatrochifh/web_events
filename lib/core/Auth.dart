import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/Login.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:flutter/material.dart'; 
import 'dart:collection';
import 'dart:convert'; 
import 'LocalData.dart';

class Auth{

  LocalData localData = new LocalData(); 

  /*
    Vamos checar se o usuário está logado no app 
    @Return (bool)
  */
  hasConnected() async {
    //Validamos se a sessão é válida.
    var response = await this.localData.getString("session"); 

    if(response.isNotEmpty){
      //Vamos decodificar
      HashMap<String, dynamic> sessionHashMap = HashMap<String, dynamic> .from(json.decode(response));
      //Se não for vazia, vamos retornar true
      if(sessionHashMap.containsKey("user_session") && sessionHashMap["user_session"].isNotEmpty) return true;
    } else {
      return false;
    }
    return false;
  }

  /*
    Retorna a se sessão do usuário 
    @Return Map<String, String>
  */
  getUserSession() async {  

    //Validamos se a sessão é válida.
    var response = await this.localData.getString("session"); 

    if(response.isNotEmpty){
       
      Map<String, dynamic> sessionHashMap =  json.decode(response);

      //Vamos pegar os dados do usuário e passar para entidade usuário
      User user  = new User.fromJson(sessionHashMap["user_data"]); 

      //Vamos pegar os dados do evento e passar para a entidade evento.
      Event event = new Event.fromJson(sessionHashMap["event_data"]);  

      sessionHashMap["user_data"]  = user;
      sessionHashMap["event_data"] = event;

      //Se não for vazia, vamos retornar true
      if( sessionHashMap["user_session"].isNotEmpty ) return sessionHashMap;

    } 

    return null; 
  }
  
  /*
    Logout e apaga os dados salvos da sessão.
    @Return null.
  */
  logout() async {
    /*  
      Vamos nos comunicar com a nossa API para atualizar que a sessão foi encerrada
    */
    debugPrint("Falta comunicar com a nossa API para atualizar que a sessão foi encerrada");

    /*
      Deu tudo certo, vamos apagar os dados aqui no celular
    */
    await this.localData.remove("session");  

    return true;
  }


  /*
    Cada vez que o usuário logar, vamos salvar os dados dele.
    Uma sessão precisa durar muito tempo, para o usuário poder acessar os dados offline.
  
    @Return (bool)
  */
  saveSession(String token, User user, Login login){
    HashMap<String, dynamic> sessionMap = new HashMap();

    sessionMap["user_session"] = token;
    sessionMap["user_data"] = user.toJson();
    sessionMap["event_data"] = login.event.toJson();

    String sessionMapJson = json.encode(sessionMap); 

    //Vamos salvar a sessão e os dados do usuário
    localData.setString("session", sessionMapJson);

    saveEventSession(login);

    return true;
  }

  /* 
   *  Retorna todos os eventos já logados.
   * (O login fica salvo localmente)
   */
  getEventsSessions() async {
    var response = await this.localData.getString("events");
    
    if (response.isEmpty) {
      return <String, Login>{};
    }

    return json.decode(response);
  }

   /* 
   *  Retorna o evento atual
   */
  getCurrentEvent() async {
    var response = await this.localData.getString("currentEvent");
    
    if (response.isEmpty) {
      return null;
    }

    return Event.fromJson(json.decode(response));
  }

   /* 
   *  Salvar a sessão efetuada pelo usuário
   * (O login fica salvo localmente)
   */
  saveEventSession(Login login) async {
    Map<String, dynamic> events = await getEventsSessions();
    if (events.isEmpty) {
      events['0'] = login;
    } else {
      bool found = false;
      Map.from(events).forEach((key, oldLogin) {
        if (oldLogin != null && oldLogin['event'] != null) {
          oldLogin = Login.fromJson(oldLogin);
          if (oldLogin.event.id.toString() == login.event.id.toString()) {
            /* 
            * Se o usuário já tiver feito um login anteriormente para este evento, 
            * vamos sobrescrever
            */
            found = true;
            return;
          }
        }
      });
      if (!found) events[(events.length).toString()] = login.toJson();
    }

    await this.localData.setString("events", json.encode(events));
    await this.localData.setString("currentEvent", json.encode(login.event.toJson()));
  }

  /*
   * Vamos atualizar os dados do usuário localmente.
   * @Return (bool)
  */
  Future<dynamic> updateUser( User user ){
    HashMap<String, dynamic> sessionMap = new HashMap(); 

    return getUserSession().then((results){

      if( results == null ){ 
        debugPrint("Falha em atualizar dados do usuário");
        return null;
      }  

      sessionMap["user_session"] = results['user_session'];
      sessionMap["user_data"]    = user.toJson();
      sessionMap["event_data"]   = results['event_data'];

      String sessionMapJson = json.encode(sessionMap); 

      //Vamos salvar a sessão e os dados do usuário
      localData.setString("session", sessionMapJson);

      debugPrint("Atualizando dados para o usuário: ${user.name}");
      return true;
    });
  }
}