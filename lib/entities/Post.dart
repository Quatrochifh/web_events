import 'Entity.dart';
import 'User.dart';

class Post extends Entity {

  // Autor do post
  User _user = new User();

  // Descricao do post
  String _content = "";

  // Anexo do post
  dynamic _attachment = "";

  // Status
  String _status = "";

  // ID
  int    _id = -1; 

  // ID de quem publicou
  int    _userId = -1;

  // ID do POST pai (Se tiver, esse post atual será uma resposta/reply)
  int    _parentId = -1;

  // Número de curtidas
  int    _likes = 0;

  // Componente que receberá o post
  String _reference = "";

  // ID do componente que receberá o post
  int    _referenceId = 0;

  // Tem anexo
  bool _hasAttachment = false;

  // Há quanto tempo publicou 
  String _publishedAt = "";

  // O usuário atual reagiu este post?
  bool _reacted = false;

  // Fixado?
  bool _fixed = false;

  // Tópico oficial
  bool _oficial = false;

  // Quantidade de replies
  int _replies = 0;

  // Link do post
  String _link = "";

  Post({int id = 0}) {
    this._id = id;
  }

  String get reference => this._reference;

  int get referenceId => this._referenceId;

  String get content   => this._content;

  String get publishedAt  => this._publishedAt;

  String get status => this._status;

  int get id => this._id;

  int get userId => this._userId;

  int get likes => this._likes;

  int get parentId=> this._parentId;

  User get user => this._user;

  int get replies => this._replies;

  String get link => this._link;

  bool get hasLink => this._link.isNotEmpty;

  bool get reacted => this._reacted;

  dynamic get attachment => this._attachment;

  bool get hasAttachment => this._hasAttachment;

  bool get oficial => this._oficial;

  bool get fixed => this._fixed;

  set reference(String reference) {
    this._reference = reference;
  }

  set referenceId(int referenceId) {
    this._referenceId = referenceId;
  }

  set content(String content) {
    this._content = content;
  }

  set attachment(dynamic attachment) {
    this._attachment = attachment;
  }

  set hasAttachment(bool hasAttachment) {
    this._hasAttachment = hasAttachment;
  }

  set publishedAt(String publishedAt) {
    this._publishedAt = publishedAt;
  }

  set status(String status) {
    this._status = status;
  }

  set id(int id) {
    this._id = id;
  }

  set link(String link) {
    this._link = link;
  }

  set fixed(bool fixed) {
    this._fixed = fixed;
  }

  set oficial(bool oficial) {
    this._oficial = oficial;
  }

  set userId(int userId) {
    this._userId = userId;
  }

  set parentId(int parentId) {
    this._parentId = parentId;
  }

  set replies(int replies) {
    this._replies = replies;
  }

  set user(User user) {
    this._user = user;
  }

  set likes(int likes) {
    this._likes = likes;
  }

  set reacted(bool reacted) {
    this._reacted = reacted;
  }
}