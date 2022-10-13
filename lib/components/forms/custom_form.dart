import 'package:appweb3603/components/form/widget_input.dart';
import 'package:flutter/material.dart'; 

mixin CustomForm <T extends StatefulWidget> on State<T>{  

  Map<String, GlobalKey<InputState>> formKeys = { } ;

  Map<String, FocusNode > formFocus = { };

  Function? onFinalSubmit;

  Function? onFinalSubmitError;

  bool? success;

  String message = "";

  void onSubmitFunction(GlobalKey currentKey) {
    bool? nextFocus;

    int keys = 0;
    
    formKeys.forEach((key, value) {

      keys++;

      if(nextFocus == true) {
        FocusScope.of(context).requestFocus( formFocus[key] );
        nextFocus = null;
        return;
      }

      if( value == currentKey ){ 
        if( formKeys[key]!.currentState!.inputController().text.isNotEmpty ){ 
          nextFocus = true;
        }else{
          //O seletor vai pro input atual ainda, já que ele está vazio
          FocusScope.of(context).requestFocus( formFocus[key] );
          return;
        } 
      }

      if( keys == formKeys.length ){
        /*
          O submit final, é apenas nas filhas do Form, mas se o focus do campo for o ultimo, precisamos chamar o submit da filha... 
          Por isso, precisamos que a filha salve a funcao submit final na variável onFinalSubmit ...
        */
        onFinalSubmit!();
      }

    });
  }

  void submit( Function f ){

    int errors = 0;

    String error = "";

    formKeys.forEach((k, v){ 
      if( v.currentState != null && v.currentState!.inputController().text.isEmpty){
        //error = "Algum campo está vazio."; 
        //errors++;
        //return; 
      } 
    });

    if( errors == 0 ){
      f();  
      FocusScope.of(context).unfocus();
    }else{
      onFinalSubmitError!( error );
    }
  }
}