import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:financial_goal_tracker/domain/repository.dart';

import 'dart_export.dart';
import 'dio_adapter.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl(this.dio);

  final Dio dio;

  late final _dioHelper = DioHelper(dio);

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
    // TODO: implement postTarget
    throw UnimplementedError();
  }
}
