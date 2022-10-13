// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Connect on _Connect, Store {
  final _$hasConnectedAtom = Atom(name: '_Connect.hasConnected');

  @override
  Observable<bool> get hasConnected {
    _$hasConnectedAtom.reportRead();
    return super.hasConnected;
  }

  @override
  set hasConnected(Observable<bool> value) {
    _$hasConnectedAtom.reportWrite(value, super.hasConnected, () {
      super.hasConnected = value;
    });
  }

  final _$_ConnectActionController = ActionController(name: '_Connect');

  @override
  void setConnectionStatus(bool status) {
    final _$actionInfo = _$_ConnectActionController.startAction(
        name: '_Connect.setConnectionStatus');
    try {
      return super.setConnectionStatus(status);
    } finally {
      _$_ConnectActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hasConnected: ${hasConnected}
    ''';
  }
}
