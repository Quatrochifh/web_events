import 'package:mobx/mobx.dart';

part 'connect.g.dart';

class Connect = _Connect with _$Connect;

abstract class _Connect with Store{ 

  @observable 
  Observable<bool> hasConnected = Observable( true );

  @action
  void setConnectionStatus( bool status ){ 
    hasConnected.value = status;
  }  


}