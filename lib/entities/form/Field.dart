import 'package:appweb3603/entities/Entity.dart';

class Field extends Entity {

  String _title = "";
  String _name = "";
  String _type = "";
  String _fieldType = "";
  String _value = "";
  String _string = "";
  Map _options = {};
  bool _required = false;
  int _objectId = 0;
  String _keyName = "";
  
  Field ({
    String title = "",
    String name = "",
    String type = "",
    String fieldType = "",
    String value = "",
    String keyName = "",
    dynamic options, // Map<dynamic, dynamic>
    bool required = false,
    int objectId = 0,
  }) {
    _title = title;
    _name = name;
    _type = type;
    _fieldType = fieldType;
    _value = value;
    _options =  options;
    _required = required;
    _objectId = objectId;
    _keyName = keyName;
  }

  String get title => _title;

  String get name => _name;

  String get type => _type; //Text, int ...

  String get fieldType => _fieldType;  // Input / Checkbox ...

  String get value => _value;

  Map get options => _options;

  bool get required => _required;

  int get objectId => _objectId;

  String get keyName => _keyName;

}