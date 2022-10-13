import 'package:appweb3603/style.dart';
import 'package:flutter/cupertino.dart'; 
import 'Entity.dart'; 

class Notification extends Entity {

  //ID da notificação.
  int _id = 0;

  //Título da notificação.
  String _title = "";
  
  //Descrição da notificação.
  String _description = "";

  //Link de um endereço WEB.
  String _linkUrl = "";

  /*
    Rota de acesso se a notificação não for linkada. 
    Espera-se dois items. 
      'name'  : nome da rota, 
      'arguments': { key : value }.
  */
  Map<String, dynamic> _route = { };

  //Valor da rota
  String _routeValue = "";

  //Nome da rota
  String _routeName = "";

  //Icone da notificação
  String _icon = "";

  //Notificação Visualizada (na base de dados localmente)
  int _viewed = 0;

  //Datetime de registro
  String _dateRegister = "";

  //Datetime de visualização
  String _dateViewed = "";

  Notification({id = -1, dateViewed = "", viewed = 0, routeName = "", routeValue = "", icon = "", dateRegister = "", title = "", description = "",  linkUrl = "", Map<String, dynamic>  route = const {}}){
    this._id = id;
    this._title = title;
    this._description  = description;
    this._linkUrl = linkUrl;
    this._route = route; 
    this._routeName = routeName; 
    this._routeValue = routeValue; 
    this._icon = icon;
    this._dateRegister = dateRegister ?? "";
    this._dateViewed = dateViewed ?? "";
    this._viewed = viewed ?? 0;
  }

  int get id              => this._id; 

  String get dateRegister => this._dateRegister;

  String get dateViewed   => this._dateViewed;

  int get viewed   => this._viewed;

  String get title        => this._title;

  String get description  => this._description; 

  String get linkUrl      => this._linkUrl;

  String get routeValue   => this._routeValue;

  String get routeName   => this._routeName;

  Map<String, dynamic> get route => this._route;

  IconData icon(){ 
    return globalIcons[this._icon] ?? CupertinoIcons.plus;
  }

  void setDateViewed (String dateViewed) {
    this._dateViewed = dateViewed;
  }

  set dateRegister(String dateRegister) {
    this._dateRegister = dateRegister;
  }

  set title(String title) {
    this._title = title;
  }

  toMap() => {
    'title'  : _title,
    'description'  : _description,
    'dateRegister'  : _dateRegister,
    'dateViewed'  : _dateViewed,
    'routeValue'  : _routeValue,
    'routeName'  : _routeName,
    'icon' : _icon,
    'viewed' : _viewed
  };
}