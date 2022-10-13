import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


/*
  Nesta classe, vamos acessar os dados armazenados no proprio smartphone.
  APENAS CLASSES EM core poderão acessar este arquivo
*/
class LocalData { 

  setString( String key, String value ) async {  
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();  
      prefs.setString( key, value ); 
    }catch( e ){
      SharedPreferences.setMockInitialValues({});
    } 
  }

  remove(String key) async { 
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();    
      return prefs.remove(key); 
    }catch( e ){
      SharedPreferences.setMockInitialValues({});
      debugPrint("Falha ao remover item $key da memória.");
      return false;
    }    
  }

  Future<String> getString( String key ) async {  
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();    
      return prefs.getString( key ) ?? "";   
    }catch( e ){
      SharedPreferences.setMockInitialValues({});
      return "";
    }    
  }

}