import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:financial_goal_tracker/domain/repository.dart';

import 'dart_export.dart';
import 'helpers/dio_helper.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl(this.dio);

  final Dio dio;

  late final _dioHelper = DioHelper(dio);

  //TODO: Add google script API
  final url = "";

  @override
  Future<Either<String, EntryResponse>> deleteEntry(String entryId) {
    // TODO: implement deleteEntry

    throw UnimplementedError();
  }

  @override
  Future<Either<String, EntryResponse>> getEntries() {
    // TODO: implement getEntries

    throw UnimplementedError();
  }

  @override
  Future<Either<String, EntryResponse>> postEntry(EntryPayload entry) {
    // TODO: implement postEntry

    throw UnimplementedError();
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
