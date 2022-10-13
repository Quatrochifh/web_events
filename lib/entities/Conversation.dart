import 'Entity.dart';

class Conversation extends Entity {

  //Data de registro 
  String _dateRegister = "";
 
  //contento da mensagem
  String _content = "";
 
  //Id da mensagem
  int   _id = -1;

  //Id de quem enviou
  int   _senderID = -1;

  //URL do anexo
  String   _attachmentUrl = "";

  //Id de quem receberá
  int   _receiverID = -1;

  //Nome do usuário receptor da mensagem.
  String _receiverName = ""; 

  //Imagem do usuário receptor da mensagem.
  String _receiverAvatar = "";

  //Nome do usuário autor da mensagem.
  String _senderName = ""; 

  //Imagem do usuário autor da mensagem.
  String _senderAvatar = "";

  bool _author = false;

  Conversation({attachmentUrl = "", author = false, content = "", senderId = 0, receiverID = 0, id = 0, dateRegister = "", receiverName = "", receiverAvatar = "", senderName = "", senderAvatar = ""}){
    this._receiverName     = receiverName ?? "Guest"; 
    this._receiverAvatar   = receiverAvatar ?? ""; 
    this._senderName     = senderName ?? "Guest"; 
    this._senderAvatar   = senderAvatar ?? ""; 
    this._content      = content; 
    this._senderID     = senderId; 
    this._receiverID   = receiverID; 
    this._id           = id;
    this._dateRegister = dateRegister ?? "";
    this._author       = author;
    this._attachmentUrl = _attachmentUrl;
  }

  String get attachmentUrl => this._attachmentUrl;
  String get dateRegister =>  this._dateRegister;
  String get content      => this._content;
  String get receiverName     => this._receiverName;
  String get receiverAvatar   => this._receiverAvatar;
  String get senderName     => this._senderName;
  String get senderAvatar   => this._senderAvatar;
  int get id              => this._id;
  int get senderID        => this._senderID;
  int get receiverID      => this._receiverID;
  bool get author         => this._author;
  
  set attachmentUrl(String attachmentUrl) {
    this._attachmentUrl = attachmentUrl;
  }

  set author (bool author) {
    this._author = author;
  }

  set dateRegister (String dateRegister) {
    this._dateRegister = dateRegister;
  }

  set receiverName (String receiverName) {
    this._receiverName = receiverName;
  }

  set receiverAvatar (String receiverAvatar) {
    this._receiverAvatar = receiverAvatar;
  }

  set senderName (String senderName) {
    this._senderName = senderName;
  }

  set senderAvatar (String senderAvatar) {
    this._senderAvatar = senderAvatar;
  }

  set content (String content) {
    this._content = content;
  }  

  set id (int id) {
    this._id = id;
  } 

  set senderID (int senderID) {
    this._senderID = senderID;
  } 

  set receiverID (int receiverID) {
    this._receiverID = receiverID;
  } 
 
}