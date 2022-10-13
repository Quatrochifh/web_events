import 'Entity.dart';

class Transmission extends Entity {

 
  //Título
  String _title = "";

  //Descrição
  String _description = "";

  //Data de registro
  String _dateRegister = "";

  //URL do video no VIMEO
  String _videoUrl = "";

  //Thumbnail do video no VIMEO
  String _thumbnail = "";

  //Duração do vídeo
  String _duration  = "";

  //Live externa
  String _externo  = "";
 
  //Id 
  int   _id = -1;

  //Plays 
  int _plays   = 0;
 
  Transmission( { plays = 0, externo = "nao", title = "" , duration = "", videoUrl = "", thumbnail = "", description = "" , id = -1 , dateRegister = "" } ) {
    _title          = title;
    _description    = description;
    _id             = id;
    _dateRegister   = dateRegister; 
    _videoUrl       = videoUrl;
    _thumbnail      = thumbnail;
    _duration       = duration;
    _plays          = plays;
    _externo        = externo;
  }

  String get externo        => this._externo;

  String get title          => this._title;  

  String get description    => this._description;  

  String get dateRegister   => this._dateRegister;  

  String get videoUrl       => this._videoUrl;  

  String get thumbnail      => this._thumbnail;   

  String get duration       => this._duration;   

  int    get plays          => this._plays;

  int get id                => this._id; 

  String? videoId(){

    _videoUrl = _videoUrl.replaceAll('http://', '');
    _videoUrl = _videoUrl.replaceAll('https://', '');  

    if( _videoUrl.split('/').length < 2 ) return '';

    String? videoId = _videoUrl.split('/')[1];

    return videoId;
  }

  set externo( String externo ){
    this._externo = externo;
  }

  set thumbnail( String thumbnail ){
    this._thumbnail = thumbnail;
  }  

  set duration( String duration ){
    this._duration = duration;
  }  

  set title( String title ){
    this._title = title;
  }  

  set description( String description ){
    this._description = description;
  }  

  set dateRegister( String dateRegister ){
    this._dateRegister = dateRegister;
  }  

  set id( int id ){
    this._id = id;
  } 

  set plays( int plays ){
    this._plays = plays;
  } 
}