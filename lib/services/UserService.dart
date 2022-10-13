import 'dart:convert';
import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/core/ServiceConnect.dart';
import 'package:appweb3603/entities/Event.dart';
import 'package:appweb3603/entities/Login.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/messages.dart';
import 'package:appweb3603/services/Service.dart';
import 'package:flutter/rendering.dart';

import '../core/Auth.dart';

class UserService extends Service {

  Auth auth = new Auth();


 /*
  * Solicitar recuperação de conta
  */
  Future accountExclusion() async {
    Map<String, dynamic> params = <String, dynamic>{};

    params['authToken'] = await UserService.getCurrentUserToken() ?? "";
    params['event_id'] = await UserService.getCurrentUserEventId() ?? "";
    params['event_id'] = params['event_id'].toString();

    //Vamos nos conectar ao sistema
    return await serviceConnect('profile/accountExclusion', 'POST', params).then((results) {
      if(results == null){
        return globalMessages['NO_RESULTS'];
      }
      if(results['status'] != 1){ 
        return results['message'].runtimeType.toString() == 'String' ? globalMessages[results['message'].toString()] ?? results['message'].toString() : globalMessages['NO_RESULTS'];
      }
      return results['status'] == 1;
    });
  }
  
  /*
  * Solicitar recuperação de conta
  * @Param  (string) email
  * @Return (string) token
  */
  Future recoverPassword(String email) async {
    Map<String, dynamic> params = <String, dynamic>{};
    params['email']      = email;

    //Vamos nos conectar ao sistema
    return await serviceConnect('auth/recover', 'POST', params).then((results) {
      if(results == null){
        return globalMessages['NO_RESULTS'];
      }
      if(results['status'] != 1){ 
        return results['message'].runtimeType.toString() == 'String' ? globalMessages[results['message'].toString()] ?? results['message'].toString() : globalMessages['NO_RESULTS'];
      }
      return results;
    });
  }

  /*
  * Resetar a senha
  * @Param  (string) password
  * @Param  (string) code
  * @Param  (string) token
  * @Return (string|bool)
  */
  Future resetPassword(String password, String code, String token) async {
    Map<String, dynamic> params = <String, dynamic>{};
    params['code']             = code;
    params['token']            = token;
    params['new_password']         = password;
    params['confirm_new_password']  = password;

    //Vamos nos conectar ao sistema
    return await serviceConnect('auth/reset', 'POST', params).then((results) {
      if(results == null || results['status'] != 1){ 
        return results['message'].runtimeType.toString() == 'String' ? globalMessages[results['message'].toString()] ?? results['message'].toString() : globalMessages['NO_RESULTS'];
      }
      return results;
    });
  }


  /*
    @Param (string) E-mail
    @Param (string) Password
    @Param (string) Código do evento
  */
  Future makeNormalLogin(String email , String password, String eventCode) async {

    Map<String, dynamic> loginParams = <String, dynamic>{};
    loginParams['email']      = email;
    loginParams['password']   = password;
    loginParams['event_code'] = eventCode;

    //Vamos nos conectar ao sistema
    return await serviceConnect('auth/login', 'POST', loginParams).then((results) {  

      if (results == null) {
        return globalMessages['NO_RESULTS'];
      }

      if (results['status'] != 1) {
        return results['message'].runtimeType.toString() == 'String' ? results['message'] : globalMessages['NO_RESULTS'];
      }

      //Vamos pegar o token e salvar na memória
      String token = results['message']['token'] ?? "";

      if (token.isEmpty) {
        debugPrint(results.toString());
        return results['message'].runtimeType.toString() == 'String' ? results['message'] : globalMessages['NO_RESULTS'];
      }

      Map<String, String> medias = {};

      if (results['message']['user']['medias'] != null && results['message']['user']['medias'].isNotEmpty) {
        /*
          * Vamos carregar as midias sociais do usuário 
        */
        results['message']['user']['medias'].forEach((k, v){
          medias[k] = v;
        });
      }

      User user = new User();   
      
      user.name = results['message']['user']['name'] ?? "";
      user.email = results['message']['user']['email'] ?? "";
      user.avatar = results['message']['user']['avatar'] ?? "";
      user.company = results['message']['user']['company'] ?? "";
      user.role = results['message']['user']['company_role'] ?? "";
      user.telephone = results['message']['user']['telephone'] ?? "";
      user.firebaseToken = results['message']['user']['firebase_token'] ?? "";
      user.authToken = token;
      user.medias = medias;
      user.id = results['message']['user']['id'] ?? 0;

      Event event = new Event(); 

      event.title = results['message']['event']['title'] ?? "";
      event.description = results['message']['event']['description'] ?? "";
      event.id = results['message']['event']['id'] ?? 0;
      event.startDatetime = results['message']['event']['start_datetime'] ?? "";
      event.endDatetime = results['message']['event']['end_datetime'] ?? "";
      event.code = results['message']['event']['code'] ?? "";
      event.logo = results['message']['event']['profile_image'] ?? "";
      event.background = results['message']['event']['background_image'] ?? "";
      event.location = results['message']['event']['location'] ?? "";
      event.localityComplement = results['message']['event']['locality_complement'] ?? "";
      event.localityNumber = results['message']['event']['locality_number'].toString();
      event.localityStreet = results['message']['event']['locality_street'] ?? "";
      event.localityZipCode = results['message']['event']['locality_zip_code'] ?? "";

      Map<String, String> social = {};
      if (results['message']['event']['social_medias'].isNotEmpty) {
        social = new Map<String, String>.from(jsonDecode(results['message']['event']['social_medias']));
      }

      event.social = social;

      Login login = new Login(event: event, email: email, password: password);
       

      /*
       * Vamos salvar a sessão do usuário logado.
      */
      this.auth.saveSession(token, user, login);

      return true;
    }); 
  }


  /*
    Vamos pegar o token do usuario atual que esteja logado 
    @Return (String) O Token ou null
  */
  static Future? getCurrentUserToken() async {

    Auth auth = new Auth();

    return await auth.getUserSession().then((response) { 
      if (response == null) { 
        return null;
      }else{  
        /*
          Depois validar a data de login/sessao
        */
        return response["user_session"]; 
      }
    });  
  }


  /*
    Vamos pegar o ID do evento o qual usuário participa
    @Return (String) O Token ou null
  */
  static Future? getCurrentUserEventId() async {

    Auth auth = new Auth();

    return await auth.getUserSession().then((response) { 
      if (response == null) { 
        return null;
      }else{  
        /*
          Depois validar a data de login/sessao
        */  
        return response["event_data"].id ; 
      }
    });  
  }

  /*
    Vamos pegar o ID do usuário atual
    @Return (String) O Token ou null
  */
  static Future<dynamic> getCurrentUserId() async {

    Auth auth = new Auth();

    return await auth.getUserSession().then((response) { 
      if (response == null) { 
        return null;
      }else{  
        /*
          Depois validar a data de login/sessao
        */  
        return response["user_data"].id ; 
      }
    });  
  }

  /*
    @Param (string) token
  */
  validateSessionToken(String token) {

  }

  /*
   * Atualizar firebaseToken do usuário
   * @Return bool/null/String
  */
  Future<dynamic>? updateFirebaseToken(String firebaseToken) async {

    String? authToken = await UserService.getCurrentUserToken();

    Map<String, dynamic> updateParams = <String, dynamic>{};

    int? currentEventId = await UserService.getCurrentUserEventId();

    updateParams['event_id'] = currentEventId.toString();

    // Vamos setar o token da sessão do usuário.
    updateParams['authToken'] = authToken ?? "";

    // Firebase Token
    updateParams['firebaseToken'] = firebaseToken;
 
    return await serviceConnect('profile/updateFirebaseToken', 'POST', updateParams).then((results) {

      if (results == null) {
        return false;
      }

      if (results['status'] == 1) {
        User currentUser = globalDIContainer.get(User) as User;
        currentUser.firebaseToken = firebaseToken;
        globalDIContainer.update(User, currentUser);
      }

      return results['status'] != 1 ? results['message'] : true ;
    });

  }

  /*
   * Atualizar dados do perfil do usuário
   * @Param  String
   * @Return bool/null/String
  */
  Future<dynamic>? updateProfile(User user, {String route = "update"}) async {
    dynamic userMap = user.toJson(); 
    userMap['id'] = userMap['id'].toString();

    String? authToken = await UserService.getCurrentUserToken();

    int? currentEventId = await UserService.getCurrentUserEventId();

    Map<String, dynamic> userParams = <String, dynamic>{ }; 

    // Vamos setar o token da sessão do usuário.
    userMap['authToken'] = authToken ?? "";

    // Vamos setar o id do evento
    userParams['event_id'] = currentEventId != null ? currentEventId.toString() : "0";

    // Exibir perfil do usuário ? 
    userMap['showProfile'] = userMap['showProfile'] == true ? '1' : '0';

    switch(route) {
      case "medias":
        route = 'changeSocialMedias';
      break;
      case 'privacity':
        route = 'changeProfileVisibility';
      break;
      default:
        route = 'update';
      break;
    }
 
    return await serviceConnect('profile/$route', 'POST', {...userParams, ...userMap}).then((results) async {

      if (results == null) {
        return false;
      }

      if (results['status'] == 1) {
        // Pega o usuário atual no controller
        User user = globalDIContainer.get(User) as User;

       // if (route == 'update') {
          user.name = results['message']['user']['name'] ?? "";
          user.email = results['message']['user']['email'] ?? "";
          user.avatar = results['message']['user']['avatar'] ?? "";
          user.company = results['message']['user']['company'] ?? "";
          user.role = results['message']['user']['company_role'] ?? "";
          user.telephone = results['message']['user']['telephone'] ?? "";
      //  }

      //  if (route == 'changeSocialMedias') {
          Map<String, String> medias = {};
          if (results['message']['user']['medias'] != null && results['message']['user']['medias'].isNotEmpty) {
            results['message']['user']['medias'].forEach((k, v){
              medias[k] = v;
            });
          }
          user.medias = medias;
      //  }

      //  if (route == 'changeProfileVisibility') {
          user.showProfile = results['message']['user']['show_profile'].toString() == '1';
      //  }
        globalDIContainer.update(User, user);
        await this.auth.updateUser(user);
      }

      return results['status'] != 1 ? results['message'] : true;
    });

  }


  /*
   * Atualizar senha
   * @Return bool/null/String
  */
  Future<dynamic>? updatePassword(String currentPassword, String newPassword) async {

    String? authToken = await UserService.getCurrentUserToken();

    int? currentEventId = await UserService.getCurrentUserEventId();

    if (authToken == null || currentEventId == null) {
      authToken = "";
      currentEventId = 0;
    }
 
    return await serviceConnect('profile/changePassword', 'POST', { 'authToken' : authToken, 'event_id' : currentEventId.toString(), 'currentPassword' : currentPassword, 'newPassword' : newPassword }).then((results) {

      if (results == null) {  
        return;
      }

      if (results['status'] == 1) {
        return true;
      }else{
        if (results['message'].runtimeType.toString() == 'List<dynamic>') {
          return results['message'][0];
        }
        return results['message'];
      } 
    });

  }
}