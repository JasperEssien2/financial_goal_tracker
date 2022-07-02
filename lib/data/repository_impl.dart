import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:financial_goal_tracker/domain/repository.dart';

import 'dart_export.dart';
import 'helpers/dio_helper.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl(this.dio);

  final Dio dio;

  late final _dioHelper = DioHelper(dio);

  final url =
      "https://script.google.com/macros/s/AKfycby26BbBsbXGJwI4L_5hTw3IfbZoOIgAltWe0_L3ApHKXQNfQXhlnTtgCHMuQnFxTtZI/exec";

  @override
  Future<Either<String, EntryResponse>> deleteEntry(String entryId) {
    return _dioHelper
        .doPost(url, (data) => EntryResponse.fromJson(data['data']), query: {
      'id': entryId,
      'action': 'deleteEntry',
    });
  }

  @override
  Future<Either<String, EntryResponse>> getEntries() {
    return _dioHelper.doGet(
      url,
      (data) => EntryResponse.fromJson(data['data']),
      query: {
        'action': 'getEntries',
      },
    );
  }

  @override
  Future<Either<String, EntryResponse>> postEntry(EntryPayload entry) {
    return _dioHelper.doPost(
      url,
      (data) => EntryResponse.fromJson(data['data']),
      query: {
        'action': 'postEntry',
      },
      body: entry.toJson(),
    );
  }

  @override
  Future<Either<String, double>> postTarget(double target) {
    return _dioHelper.doPost(
      url,
      (data) => (data['data'] as int).toDouble(),
      query: {
        'action': 'postTarget',
      },
      body: {'target': target},
    );
  }

  @override
  Future<Either<String, double>> getTarget() {
    return _dioHelper.doGet(
      url,
      (data) => (data['data'] as int).toDouble(),
      query: {
        'action': 'getTarget',
      },
    );
  }
}
