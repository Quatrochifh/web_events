import 'package:appweb3603/bloc/Bloc.dart';
import 'package:appweb3603/core/Auth.dart';
import 'package:appweb3603/helpers.dart';
import 'package:appweb3603/messages.dart';
import 'package:appweb3603/services/UserService.dart';

class Login extends Bloc{

  Login () : super();

  /*
   * Fazer um login
   * @Return true|String error
  */
  Future<dynamic> normalLogin({String? email, String? password, bool? checkBoxTerms, String? eventCode}) {

    String error = "";
  
    if(email == null || email.length <= 1 || !isEmail(email) ){
      error = globalMessages['INVALID_EMAIL']!;
    } else if(password == null || password.length <= 5){
      error = globalMessages['INVALID_PASSWORD']!;
    } else if(checkBoxTerms != true){
      error = globalMessages['ACCEPT_TERMS']!;
    }

    if (error.isNotEmpty) {
      return Future.delayed(Duration(seconds: 0), (){ return error; });
    }

    return (diContainer.get(UserService)).makeNormalLogin(email, password, eventCode).then((results) {
      if (results != true) {
        // Houve erro
        return results;
      }
      return true;
    }); 
  }


  Future<dynamic> fetchEventsLogin() async {
    Auth auth = diContainer.get(Auth) as Auth;
    
    var response = await auth.getEventsSessions();
    
    if (response != null && response.isNotEmpty) {
      return response;
    }

    return {};
  }

  Future<dynamic> fetchCurrentEvent() async {
    Auth auth = diContainer.get(Auth) as Auth;
    
    var response = await auth.getCurrentEvent();
    
    if (response != null) {
      return response;
    }

    return null;
  }
}