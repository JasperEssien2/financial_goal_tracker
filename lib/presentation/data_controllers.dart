import 'package:either_dart/either.dart';
import 'package:financial_goal_tracker/data/dart_export.dart';
import 'package:financial_goal_tracker/domain/repository.dart';
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

  void setError(String left) {
    _error = left;
    state = ConnectionState.done;
  }

  void setSuccess(T right) {
    _data = right;
    state = ConnectionState.done;
  }

  bool get isLoading => _state == ConnectionState.waiting;

  bool get hasError => _state == ConnectionState.done && error != null;
}

class TargetDataController extends DataController<double> {
  TargetDataController(this.repository) : super(0);

  final Repository repository;

  Future<void> saveTarget(double target) async {
    state = ConnectionState.waiting;

    repository.postTarget(target).fold(
          (left) => setError(left),
          (right) => setSuccess(right),
        );
  }

  Future<void> fetchTarget() async {
    state = ConnectionState.waiting;

    repository.getTarget().fold(
          (left) => setError(left),
          (right) => setSuccess(right),
        );
  }
}

class EntryDataController extends DataController<EntryResponse?> {
  EntryDataController(this.repository) : super(null);

  final Repository repository;

  Future<void> fetchEntries() async {
    state = ConnectionState.waiting;

    repository.getEntries().fold(
          (left) => setError(left),
          (right) => setSuccess(right),
        );
  }

  Future<void> saveEntry(EntryPayload entry) async {
    state = ConnectionState.waiting;

    repository.postEntry(entry).fold(
          (left) => setError(left),
          (right) => setSuccess(right),
        );
  }

  Future<void> deleteEntry(String entryId) async {
    state = ConnectionState.waiting;

    repository.deleteEntry(entryId).fold(
          (left) => setError(left),
          (right) => setSuccess(right),
        );
  }
}
