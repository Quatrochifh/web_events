import 'package:appweb3603/entities/Event.dart';

import 'Entity.dart'; 

class Login extends Entity{

  Event? _event;

  String? _email;

  String? _password;

  Login({Event? event, String email = "", String password = ""}) {
    _event = event;
    _email = email;
    _password = password;
  }

  String get email =>  _email ?? "";

  String get password =>  _password ?? "";

  Event get event => _event ?? event;

  Map<String, dynamic> toJson() => {
    'email' : _email,
    'password' : _password,
    'event' : _event!.toJson()
  };

  Login.fromJson(Map<String, dynamic> json) : 
    _event = Event.fromJson(json['event']),
    _email = json['email'],
    _password = json['password'];
}