import 'package:appweb3603/entities/Entity.dart';

class Plan extends Entity {

  int _id = 0;

  int _eventId = 0;

  int _ticketsAvailable = 0;

  int _categoryId = 0;

  int _maxInstallmentNoInterest = 0;

  int _installmentLimit = 0;

  double _price = 0;

  String _status = "";

  String _title = "";

  String _description = "";

  String _code = "";

  Plan ({
    int id = 0,
    int eventId = 0,
    int ticketsAvailable = 0,
    int categoryId = 0,
    int maxInstallmentNoInterest = 0,
    int installmentLimit = 0,
    double price = 0.0,
    String title = "",
    String description = "",
    String code = ""
  }) {
    _id = id;
    _eventId = eventId;
    _ticketsAvailable = ticketsAvailable;
    _categoryId = categoryId;
    _maxInstallmentNoInterest = maxInstallmentNoInterest;
    _installmentLimit = installmentLimit;
    _price = price;
    _description = description;
    _title = title;
    _code = code;
  }

  int get id => _id;

  int get eventId => _eventId;

  int get ticketsAvailable => _ticketsAvailable;

  int get categoryId => _categoryId;

  int get maxInstallmentNoInterest => _maxInstallmentNoInterest;

  int get installmentLimit => _installmentLimit;

  double get price => _price;

  String get description => _description;

  String get title => _title;

  String get code => _code;

}