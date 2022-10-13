import 'package:appweb3603/entities/Entity.dart';

class Contact extends Entity {

  String? _name;

  String? _email;

  String? _telephone;

  String? _dateRegister;

  int? _userId;

  int? _id;


  Contact ({String name = "", String email = "", String telephone = "", int userId = 0, String dateRegister = "", int id = 0}) {
    this._name = name;
    this._email = email;
    this._telephone = telephone;
    this._dateRegister = dateRegister;
    this._userId = userId;
    this._id = id;
  }


  String? get name => this._name;

  String? get email => this._email;

  String? get telephone => this._telephone;

  String? get dateRegister => this._dateRegister;

  int? get userId => this._userId;

  int? get id => this._id;

}