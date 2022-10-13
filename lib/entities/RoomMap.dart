import 'Entity.dart';

class RoomMap extends Entity {

 
  //Título
  String _title = "";

  //Descrição
  String _description = "";

  //Data e hora de término
  String _dateRegister = "";

  //Data e hora de término
  String _url = "";
 
  //Id 
  int _id = -1;

  //Imagem do mapa
  String _mapImage = "";


 
  String get title => this._title;

  String get description => this._description;

  String get dateRegister => this._dateRegister;

  String get url => this._url;

  String get mapImage => this._mapImage;

  int get id => this._id;


  RoomMap({
    String title = "",
    String description = "",
    String dateRegister = "",
    String url = "",
    String mapImage = "",
    int id = 0,
  }){
    this._title = title;
    this._description = description;
    this._dateRegister = dateRegister;
    this._url = url;
    this._mapImage = mapImage;
    this._id = id;
  }

  
  set title(String title){
    this._title = title;
  }  

  set description(String description){
    this._description = description;
  }

  set url(String url){
    this._url = url;
  }

  set dateRegister(String dateRegister){
    this._dateRegister = dateRegister;
  }

  set id(int id){
    this._id = id;
  }  
}