import 'User.dart'; 

class Speaker extends User {

  int _speakerId = -1;

  Speaker({
    speakerId = -1,
    name = "",
    email = "", 
    avatar = "",
    level =  "",
    id = 0,
    description = "",
    background = ""
  }) :
    this._speakerId = speakerId,
    super(description: description, background: background, name: name, email: email, avatar: avatar, level: level, id: id);

  Speaker.fromJson(Map<String, dynamic> json) : super(name: json['name'], email: json['email'], avatar: json['avatar'], level: json['level'], id: json['id']);

  @override
  Map<String, dynamic> toJson() => {
    'name'  : name,
    'email' : email,
    'avatar': avatar,
    'description' : description,
    'level' : level,
    'id'    : id,
    'speakerId' : _speakerId,
  };

  set speakerId(int speakerId) {
    this._speakerId = speakerId;
  }

  int get speakerId => this._speakerId;

}