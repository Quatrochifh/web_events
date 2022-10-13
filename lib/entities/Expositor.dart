import 'Entity.dart';

class Expositor extends Entity {

 
  //Nome completo
  String _title = "";

  //Telefone
  String _telephone = "";

  //E-mail
  String _email = "";

  //Address
  String _address = "";

  //image
  String _image = "";

  //Id
  int   _id = -1;

  // WebSite
  String _url = "";

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


  Expositor({String address = "", String url = "", String telephone = "", String description = "", String title = "" , String email = "", String image = "", int id = -10 }){
    this._title = title;
    this._email = email;
    this._url = url;
    this._image = image;
    this._id = id;
    this._description = description;
    this._telephone = telephone;
    this._address = address;
  }

  void fillSocialMedias(Map<String, dynamic> medias){
    medias.forEach((key, value) {
      if(_socialMedias.containsKey(key) && value.runtimeType.toString() == 'String'){ 
        _medias[key] = value;
      }
    });
  }

  String get title   => this._title;

  String get email  => this._email;

  String get image => this._image;

  String get telephone => this._telephone;

  int get id        => this._id;

  String get address        => this._address;

  String get description => this._description;

  Map get socialMedias => this._medias;

  Map<String, String> get medias => this._medias;

  String get url => this._url;

  set medias(Map<String, String> medias) {
    this._medias = medias;
  }

  set description(String description){
    this._description = description;
  }

  set telephone(String telephone){
    this._telephone = telephone;
  }

  set title(String title){
    this._title = title;
  }

  set email(String email){
    this._email = email;
  }

  set image(String image){
    this._image = image;
  }

  set id(int id){
    this._id = id;
  }

  set address(String address){
    this._address = address;
  }

  set url(String url){
    this._url = url;
  }

}