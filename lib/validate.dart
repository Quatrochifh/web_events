import 'package:flutter/material.dart';

class Validate{

  String _currentError = "";  

  void _cleanError(){
    _currentError = "";
  }

  void _setError( String error ){
    _currentError = error;
  }

  String getError(){
    return _currentError;
  }
  

  bool validateUserFirstName( String firstName ){
    this._cleanError();

    debugPrint( firstName );

    if( firstName.trim().isEmpty ){ 
      _setError( "O nome não pode ser vazio!" );
      return false;
    }

    if( firstName.split(" ").length > 1 ){
      _setError( "O Primeiro nome não pode ser composto!" );
      return false;
    } 

    return true;
  }  

  bool validateUserLastName( String lastName ){
    this._cleanError();

    if( lastName.trim().isEmpty ){ 
      _setError( "O Sobrenome não pode ser vazio!" );
      return false;
    } 

    return true;
  }

  bool validateUserEmail( String email ){
    this._cleanError();

    if( email.trim().isEmpty ){ 
      _setError( "E-mail inválido" );
      return false; 
    }

    return true;
  }

  static bool isPhone(String input) {
    return input.contains(RegExp("^[0-9-s+()]+\$")) &&
        input.replaceAll(RegExp("[^0-9]+"), "").length > 6;
  }

}