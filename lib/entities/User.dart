import 'dart:convert';
import 'package:appweb3603/enums/userEnum.dart';

import 'Entity.dart';

class User extends Entity {
 
  //Nome completo
  String _name = "";

  //Telefone
  String _telephone = "";

  //E-mail
  String _email = "";

  //Avatar
  String _avatar = "";

  //Background
  String _background = "";

  //Nível/Tipo de usuário
  Enum _level = UserEnum.common;

  //Empresa do usuário
  String _company = "";

  //Cargo do usuário
  String _role = "";

  //Id do usuário
  int   _id = -1;

  //Token de autenticacao
  String _authToken = "";

  //Token do firebase
  String _firebaseToken = "";

  //Redes Sociais do usuário
  Map<String, String> _medias = {};

  Map<String, String> _socialMedias = { 
    'facebook' : '', 
    'instagram' : '', 
    'youtube' : '', 
    'link' : '', 
    'linkedin' : '', 
    'twitter' : '' 
  };

  String _description = "";

  bool _showProfile = true;


  User({String firebaseToken = "", String background = "", bool showProfile = true, telephone = "", description = "", authToken = "", role = "", name = "" , company = "",  email = "", avatar = "", Enum level = UserEnum.common, id = -10 }){
    this._name       = name;
    this._email      = email;
    this._avatar     = avatar;
    this._level      = level;
    this._id         = id;
    this._authToken  =  authToken;
    this._company    = company;
    this._role       = role;
    this._description= description;
    this._telephone  = telephone;
    this._showProfile = showProfile;
    this._firebaseToken = firebaseToken;
    this._background = background;
  }

  void fillSocialMedias(Map<String, dynamic> medias) {
    medias.forEach((key, value) {
      if(_socialMedias.containsKey(key) && value.runtimeType.toString() == 'String') { 
        _medias[key] = value;
      }
    });
  }

  String get authToken => this._authToken;

  String get name   => this._name;

  Enum get level  => this._level;

  String get company  => this._company;

  String get email  => this._email;

  String get avatar => this._avatar;

  String get background => this._background;

  String get telephone => this._telephone;

  int get id => this._id;

  String get role => this._role;

  String get description => this._description;

  Map get socialMedias => this._medias;

  Map<String, String> get medias => this._medias;

  bool get showProfile => this._showProfile;

  String get firebaseToken => this._firebaseToken;

  set firebaseToken(String firebaseToken) {
    this._firebaseToken = firebaseToken;
  }

  set medias(Map<String, String> medias) {
    this._medias = medias;
  }

  set description(String description) {
    this._description = description;
  }

  set authToken(String authToken) {
    this._authToken = authToken;
  }

  set company(String company) {
    this._company = company;
  }

  set role(String role) {
    this._role = role;
  }

  set background(String background) {
    this._background = background;
  }

  set telephone(String telephone) {
    this._telephone = telephone;
  }

  set name(String name) {
    this._name = name;
  }

  set email(String email) {
    this._email = email;
  }

  set level(Enum level) {
    this._level = level;
  } 

  set avatar(String avatar) {
    this._avatar = avatar;
  } 

  set id(int id) {
    this._id = id;
  }

  set showProfile(bool showProfile) {
    this._showProfile = showProfile;
  }

  User.fromJson(Map<String, dynamic> json)
      : _name = json['name'] ?? "",
        _email = json['email'] ?? "",
        _avatar = json['avatar'] ?? "",
        _level = UserEnumFunctions.toEnum(json['level']),
        _company = json['company'] ?? "",
        _role = json['role'] ?? "",
        _telephone = json['telephone'] ?? "",
        _authToken = json['authToken'] ?? "",
        _showProfile = json['showProfile'] ?? false,
        _medias = new Map<String, String>.from(jsonDecode(json['medias']) ?? <String, String>{}),
        _id = int.parse(json['id'].toString());

  Map<String, dynamic> toJson() => {
    'name' : _name,
    'email' : _email,
    'avatar' : _avatar,
    'authToken': _authToken,
    'level' : UserEnumFunctions.enumToString(_level),
    'company'    : _company,
    'role' : _role,
    'telephone' : _telephone,
    'medias' : JsonEncoder().convert(_medias),
    'id' : _id,
    'showProfile' : _showProfile
  };

  String firstName() {
    List<String> name = this._name.split(" ");
    return name[0];
  }

  String secondName() {
    List<String> name = this._name.split(" ");
    return name.length > 1 ? name[0] : "";
  }

}