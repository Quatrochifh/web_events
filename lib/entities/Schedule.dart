import 'package:appweb3603/entities/Speaker.dart';
import 'package:appweb3603/enums/userEnum.dart';

import 'Entity.dart';

class Schedule extends Entity {

  Schedule({
    String room = "",
    String link = "",
    String background = "",
    String startDateTime = "",
    String endDateTime = "",
    String title = "",
    String description = ""
    }) {
    _startDateTime = startDateTime;
    _endDateTime = endDateTime;
    _title = title;
    _link = link;
    _background = background;
    _description = description;
  }

  // Título
  String _title = "";

  // Sala do evento
  String _room = "";

  // Link
  String _link = "";
 
  // Background
  String _background = "";

  //Descrição
  String _description = "";

  //Data e hora de término
  String _startDateTime = ""; 

  //Data e hora de término
  String _endDateTime = "";

  //Status do evento
  String _status = "";

  //Usuário atual está inscrito na atividade
  bool _userHasSubscribed = false;
 
  //Id 
  int   _id = -1;
 
  //Links 
  Map<String, String> _links = { };

  //Entidade do palestrante
  Speaker _speaker = new Speaker(level: UserEnum.speaker);

  bool get userHasSubscribed  => this._userHasSubscribed;

  Map<String, String> get links => this._links;

  Speaker get speaker => this._speaker;

  String get title   => this._title;  

  String get description   => this._description;  

  String get startDateTime   => this._startDateTime; 

  String get endDateTime   => this._endDateTime; 

  String get status   => this._status;  

  String get room => this._room;

  String get background => this._background;

  String get link => this._link;

  int get id   => this._id; 

  get startHour => "${this._startDateTime.split(' ')[1].split(':')[0]}h ${this._startDateTime.split(' ')[1].split(':')[1]}"; 

  get endHour => "${this._endDateTime.split(' ')[1].split(':')[0] }h ${this._endDateTime.split(' ')[1].split(':')[1]}"; 

  set userHasSubscribed (bool userHasSubscribed){
    this._userHasSubscribed = userHasSubscribed;
  }

  set speaker(Speaker speaker){
    this._speaker = speaker;
  }

  set links(Map<String, dynamic> links){
    links.forEach((key, value) {
      this._links[key]  = value.toString();
    });
  }

  set title(String title){
    this._title = title;
  }

  set description(String description){
    this._description = description;
  }

  set room(String room){
    this._room = room;
  }

  set link(String link){
    this._link = link;
  }

  set background(String background){
    this._background = background;
  }

  set status(String status){
    this._status = status;
  }  

  set startDateTime(String startDate){
    this._startDateTime = startDate;
  } 

  set endDateTime(String endDateTime){
    this._endDateTime = endDateTime;
  }  

  set id(int id){
    this._id = id;
  }  
}