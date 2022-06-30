import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class DioHelper {
  DioHelper(this.dio);

  final Dio dio;

  Future<Either<String, R>> doGet<R>(
      String url, R Function(dynamic data) parseData) async {
    try {
      final res = await dio.get(url);

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
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await dio.post(url, data: queryParams);

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
