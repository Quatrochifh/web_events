import 'Entity.dart';

class Link extends Entity {

 
  //Título
  String _title = "";

  //Descrição
  String _description = "";

  //Data e hora de término
  String _dateRegister = ""; 

  //Data e hora de término
  String _url = "";
 
  //Id 
  int   _id = -1; 


 
  String get title          => this._title;  

  String get description    => this._description;  

  String get dateRegister   => this._dateRegister;  

  String get url            => this._url;  

  int get id                => this._id;  

  
  set title( String title ){
    this._title = title;
  }  

  set description( String description ){
    this._description = description;
  }

  set url( String url ){
    this._url = url;
  }

  set dateRegister( String dateRegister ){
    this._dateRegister = dateRegister;
  }

  set id( int id ){
    this._id = id;
  }  
}