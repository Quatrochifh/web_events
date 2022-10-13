import 'Entity.dart';

class EventPhoto extends Entity {

 
  //Nome do autor
  String _authorName = "";

  //Avatar do Autor
  String _authorAvatarUrl = "";

  //Descrição
  String _url = "";

  //Data de registro
  String _dateRegister = "";
 
  //Id 
  int   _id = -1;

  //ID do post
  int  _postID = 0;
 
  EventPhoto( { authorName = "",  postID = 0, url = "", authorAvatarUrl = "", id = -1 , dateRegister = "" } ) {
    _authorName      = authorName; 
    _id              = id;
    _dateRegister    = dateRegister; 
    _url             = url; 
    _authorAvatarUrl = authorAvatarUrl;
    _postID          = postID;
  }

  String get authorAvatarUrl => this._authorAvatarUrl;   

  String get authorName      => this._authorName;   

  String get dateRegister    => this._dateRegister;  

  String get url             => this._url;   

  int get id   => this._id;  

  int get postID => this._postID;
  
  set postID( int postID ){
    this._postID = postID;
  }

  set authorName( String authorName ){
    this._authorName = authorName;
  }  

  set authorAvatarUrl( String authorAvatarUrl ){
    this._authorAvatarUrl = authorAvatarUrl;
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