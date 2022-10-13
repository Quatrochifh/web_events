import 'Entity.dart';

class ChatMessage extends Entity {

  //Data de registro 
  String _dateRegister = "";
 
  //Texto da mensagem
  String _text = "";
 
  //Id da mensagem
  int   _id = -1;

  //Nome do usuário autor da mensagem.
  String _authorName = ""; 

  //Imagem do usuário autor da mensagem.
  String _authorAvatar = "";

  ChatMessage( {  text = "" , id = 0, dateRegister = "", authorName = "", authorAvatar = "" }  ){
    this._authorName   = authorName ?? "Guest"; 
    this._authorAvatar = authorAvatar ?? ""; 
    this._text         = text; 
    this._id           = id;
    this._dateRegister = dateRegister ?? "";
  }


  String get dateRegister =>  this._dateRegister;
  String get text         => this._text;  
  String get authorName   => this._authorName;  
  String get authorAvatar => this._authorAvatar;  
  int get id              => this._id;
  

  set dateRegister( String dateRegister ){
    this._dateRegister = dateRegister;
  }

  set authorName( String authorName ){
    this._authorName = authorName;
  } 

  set authorAvatar( String authorAvatar ){
    this._authorAvatar = authorAvatar;
  } 
  set text( String text ){
    this._text = text;
  }  

  set id( int id ){
    this._id = id;
  } 
 
}