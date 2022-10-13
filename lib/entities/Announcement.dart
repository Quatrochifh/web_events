import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart'; 
import 'Entity.dart'; 

class Announcement extends Entity {

  //ID da banner.
  int _id = 0;

  //Título da banner.
  String _title = "Testando ...";
  
  //Descrição da banner.
  String _description = "";

  //Badged
  String _badge = "";

  //Link de um endereço WEB.
  String _linkUrl = "";

  /*
    Imagem de fundo
  */
  String _backgroundImage = "";

  //Icone da banner
  String _icon = "";

  //Data de registro
  String _dateRegister = "";

  Announcement( {badge = "", id = -1 , icon = "", dateRegister = "", title = "", description = "",  linkUrl = "", backgroundImage = ""} ){
    this._id              = id;
    this._title           = title;
    this._description     = description;
    this._linkUrl         = linkUrl;
    this._backgroundImage = backgroundImage; 
    this._icon            = icon;
    this._dateRegister    = dateRegister;
    this._badge          = badge;
  }

  String get badge       => this._badge;

  int get id              => this._id; 

  String get dateRegister => this._dateRegister;

  String get title        => this._title;

  String get description  => this._description; 

  String get linkUrl      => this._linkUrl;

  String get backgroundImage => this._backgroundImage;

  IconData icon(){ 
    return globalIcons[this._icon] ?? CupertinoIcons.plus;
  }
}