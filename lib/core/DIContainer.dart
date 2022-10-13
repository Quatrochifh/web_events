/*
 * #04/05/2022
 * Classe para injeção de dependência
*/

import 'package:flutter/material.dart';

class DIContainer {

  Map<Object, Object> _injections = {};

  /*
   * @Param object : Objeto que será usado na injeção
  */
  void set(Object objectType, Object objectValue, {bool? isSingleton = true}) {
    this._injections[objectType] = objectValue;
  }

  /*
   * @Param object : Objeto que requisitado usado na injeção
   * @Return object 
  */
  Object? get(Object objectType) {
    if (this._injections.containsKey(objectType)) {
      return this._injections[objectType];
    } else {
      debugPrint("Objeto ${objectType.runtimeType.toString()} não existe");
    }

    return null;
  }

  void update(Object objectType, Object objectValue) {
    if (this._injections.containsKey(objectType)) {
      debugPrint("Objeto ${objectType.runtimeType.toString()} reusado");
      this._injections[objectType] = objectValue;
    }
  }

}