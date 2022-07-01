import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class DioHelper {
  DioHelper(this.dio);

  final Dio dio;

  Future<Either<String, R>> doGet<R>(
    String url,
    R Function(dynamic data) parseData, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await dio.get(url, queryParameters: query);

      if (res.data['success']) {
        return Right(parseData(res.data));
      } else {
        return Left(res.data['message']);
      }
    } on DioError {
      return const Left("An error occurred");
    }
  }

  Future<Either<String, R>> doPost<R>(
    String url,
    R Function(dynamic data) parseData, {
    required Map<String, dynamic> body,
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await dio.post(
        url,
        data: body,
        queryParameters: query,
      );

      if (res.data['success']) {
        return Right(parseData(res.data));
      } else {
        return Left(res.data['message']);
      }
    } on DioError {
      return const Left("An error occurred");
    }
  }
}
