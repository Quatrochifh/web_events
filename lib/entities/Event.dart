import 'Entity.dart'; 

class Event extends Entity {

  //ID do evento
  int _id = 0; 

  //Titulo do evento
  String _title = ""; 

  //Código do evento
  String _code = ""; 

  //Descricao do evento
  String _description = ""; 

  //Data de inicio do evento
  String _startDatetime = "";

  //Data fim do evento
  String _endDatetime = "";

  //Logo do evento
  String _logo = "";

  //Backgrund do evento
  String _background = "";

  //Lista de redes sociais do evento
  late Map<String, String> _social;

  //Status da inscrição
  String _subscriptionStatus = "";

  //Data de inicio da inscrição
  String _subscriptionStartDatetime = "";

  //Data de término da inscrição
  String _subscriptionEndDatetime = "";

  // location
  String _location = "";

  // CEP/Zip-Code
  String _localityZipCode = "";

  // Street/Logradouro
  String _localityStreet = "";

  // Número
  String _localityNumber = "";

  // Complemento
  String _localityComplement = "";

  Event({title = ""}){ 
    this._title = title;
  }

  set localityZipCode(String localityZipCode){
    this._localityZipCode = localityZipCode;
  }

  set localityStreet(String localityStreet){
    this._localityStreet = localityStreet;
  }

  set localityNumber(String localityNumber){
    this._localityNumber = localityNumber;
  }

  set localityComplement(String localityComplement){
    this._localityComplement = localityComplement;
  }

  set subscriptionStatus(String subscriptionStatus) {
    this._subscriptionStatus = subscriptionStatus;
  }

  set id(int id) {
    this._id = id;
  }

  set title(String title) {
    this._title = title;
  }

  set description(String description) {
    this._description = description;
  }

  set startDatetime(String startDatetime) {
    this._startDatetime = startDatetime;
  }

  set subscriptionStartDatetime(String subscriptionStartDatetime) {
    this._subscriptionStartDatetime = subscriptionStartDatetime;
  }

  set subscriptionEndDatetime(String subscriptionEndDatetime) {
    this._subscriptionEndDatetime = subscriptionEndDatetime;
  }

  set endDatetime(String endDatetime) {
    this._endDatetime = endDatetime;
  }

  set code (String code) {
    this._code = code;
  }

  set logo (String logo) {
    this._logo = logo;
  }

  set background (String background) {
    this._background = background;
  }

  set social(Map<String, String> social) {
    this._social = social; 
  }

  set location(String location){
    this._location = location;
  }

  String get subscriptionStatus => this._subscriptionStatus;

  String get subscriptionStartDatetime => this._subscriptionStartDatetime;

  String get subscriptionEndDatetime => this._subscriptionEndDatetime;
  
  int get id =>  this._id;

  String get title => this._title;

  String get description => this._description; 

  String get startDatetime => this._startDatetime;

  String get endDatetime => this._endDatetime;

  String get code => this._code;

  String get logo => this._logo;

  String get background => this._background;

  String get location => this._location;

  String get localityZipCode => this._localityZipCode;

  String get localityStreet => this._localityStreet;

  String get localityNumber => this._localityNumber;

  String get localityComplement => this._localityComplement;

  Map<String, String> get social => this._social;

  Event.fromJson(Map<String, dynamic> json)
      : _title = json['title'],
        _description = json['description'],
        _startDatetime = json['startDatetime'],
        _endDatetime = json['endDatetime'],
        _code = json['code'],
        _logo = json['logo'],
        _background = json['background'],
        _social = new Map<String, String>.from(json['social']),
        _location = json['location'] ?? "",
        _localityStreet = json['localityStreet'] ?? "",
        _localityNumber = json['localityNumber'] ?? "",
        _localityZipCode = json['localityZipCode'] ?? "",
        _localityComplement = json['localityComplement'] ?? "",
        _id = json['id'];

  Map<String, dynamic> toJson() => {
        'title' : _title,
        'description' : _description,
        'startDatetime': _startDatetime,
        'endDatetime' : _endDatetime,
        'code' : _code,
        'logo' : _logo,
        'social' : _social,
        'background' : _background,
        'id' : _id,
        'location' : _location,
        'localityZipCode' : _localityZipCode,
        'localityStreet' : _localityStreet,
        'localityNumber' : _localityNumber,
        'localityComplement' : _localityComplement,
      };

}