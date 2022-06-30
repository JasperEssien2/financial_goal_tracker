import 'package:flutter/material.dart';

abstract class DataController<T> extends ChangeNotifier {
  DataController(this._data);

  T _data;

  T get data => _data;

  String? get error => _error;
  String? _error;

  @visibleForTesting
  ConnectionState get state => _state;
  ConnectionState _state = ConnectionState.none;

  set state(ConnectionState newState) {
    if (_state == newState) {
      return;
    }
    _state = newState;
    notifyListeners();
  }

  bool get isLoading => _state == ConnectionState.waiting;

  bool get hasError => _state == ConnectionState.done && error != null;
}

class 