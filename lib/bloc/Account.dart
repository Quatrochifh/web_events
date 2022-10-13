import 'package:appweb3603/DIContainer.dart';
import 'package:appweb3603/entities/User.dart';
import 'package:appweb3603/services/UserService.dart';

class Account{ 


  UserService? _userService;

  Account({userService}){ 
    this._userService = userService;  
  }

  /*
  * Pega os dados do usuário atual e retorna um Map<String, dynamic>
  */
  Map<String, dynamic> convertCurrentUserToJson() {
    User user = (globalDIContainer.get(User)) as User;
    return user.toJson();
  }

  /*
    Atualizar senha
  */
  Future<dynamic> changePassword(String currentPassword, String newPassword){   
    return this._userService!.updatePassword(currentPassword, newPassword)!.then((results) { 
      return results;
    }); 
  }

  /*
    Atualizar perfil
  */
  Future<dynamic> updateAccount(User user, {String route = ""}){
    return this._userService!.updateProfile(user, route: route)!.then((results) { 
      return results;
    }); 
  }

  /*
    Solicitar exclusão da conta
  */
  Future<dynamic> accountExclusion(){
    return this._userService!.accountExclusion().then((results) { 
      return results;
    }); 
  }

}