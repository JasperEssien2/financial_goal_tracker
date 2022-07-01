import 'package:dio/dio.dart';
import 'package:financial_goal_tracker/data/dio_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockedDio extends Mock implements Dio {}

void main() {
  late DioHelper dioHelper;
  late MockedDio dio;

  setUp(
    () {
      dio = MockedDio();
      dioHelper = DioHelper(dio);
    },
  );

  group(
    "Test onGet",
    () {
      test(
        "Ensure that Right is returned when succes is true ",
        () async {
          _whenGetReturnRequestSuccess(dio);

          final response = await dioHelper.doGet<String>(
            'url',
            (data) => 'Hello',
            query: {'query': 'hello'},
          );

          expect(response.right, 'Hello');
          expect(() => response.left, throwsException);
          verify(() => dio.get('url', queryParameters: {'query': 'hello'}));
        },
      );

      test(
        "Ensure that Left is returned with error message when success is false ",
        () async {
          _whenGetReturnRequestSuccess(dio, successState: false);

          final response = await dioHelper.doGet<String>(
            'url',
            (data) => 'Hello',
            query: {'query': 'hello'},
          );

          expect(response.left, 'Error message');
          expect(() => response.right, throwsException);
          verify(() => dio.get('url', queryParameters: {'query': 'hello'}));
        },
      );

      test(
        "Ensure that Left is returned with error message when dio exception occured ",
        () async {
          _whenGetThrowException(dio);

          final response = await dioHelper.doGet<String>(
            'url',
            (data) => 'Hello',
            query: {'query': 'hello'},
          );

          expect(response.left, 'An error occurred');
          expect(() => response.right, throwsException);
          verify(() => dio.get('url', queryParameters: {'query': 'hello'}));
        },
      );
    },
  );

  group(
    "Test onPost",
    () {
      test(
        "Ensure that Right is returned when succes is true ",
        () async {
          _whenPostReturnRequestSuccess(dio);

          final response = await dioHelper.doPost<String>(
            'url',
            (data) => 'Hello',
            body: {'body': 'yeah'},
            query: {'query': 'hello'},
          );

          expect(response.right, 'Hello');
          expect(() => response.left, throwsException);
          verify(() => dio.post(
                'url',
                queryParameters: {'query': 'hello'},
                data: {'body': 'yeah'},
              ));
        },
      );

      test(
        "Ensure that Left is returned with error message when success is false ",
        () async {
          _whenPostReturnRequestSuccess(dio, successState: false);

          final response = await dioHelper.doPost<String>(
            'url',
            (data) => 'Hello',
            query: {'query': 'hello'},
            body: {'body': 'yeah'},
          );

          expect(response.left, 'Error message');
          expect(() => response.right, throwsException);
          verify(() => dio.post(
                'url',
                queryParameters: {'query': 'hello'},
                data: {'body': 'yeah'},
              ));
        },
      );

      test(
        "Ensure that Left is returned with error message when dio exception occured ",
        () async {
          _whenPostThrowException(dio);

          final response = await dioHelper.doPost<String>(
            'url',
            (data) => 'Hello',
            query: {'query': 'hello'},
            body: {'body': 'yeah'},
          );

          expect(response.left, 'An error occurred');
          expect(() => response.right, throwsException);
          verify(() => dio.post(
                'url',
                queryParameters: {'query': 'hello'},
                data: {'body': 'yeah'},
              ));
        },
      );
    },
  );
}

void _whenGetReturnRequestSuccess(MockedDio dio, {bool successState = true}) {
  when(
    () => dio.get(
      any(),
      queryParameters: any(named: 'queryParameters'),
    ),
  ).thenAnswer(
    (invocation) => Future.value(
      Response(
        data: {
          'success': successState,
          'data': {},
          if (!successState) 'message': "Error message",
        },
        requestOptions: RequestOptions(path: ''),
      ),
    ),
  );
}

void _whenGetThrowException(MockedDio dio) {
  when(
    () => dio.get(
      any(),
      queryParameters: any(named: 'queryParameters'),
    ),
  ).thenThrow(
    DioError(requestOptions: RequestOptions(path: '')),
  );
}

void _whenPostReturnRequestSuccess(MockedDio dio, {bool successState = true}) {
  when(
    () => dio.post(
      any(),
      data: any(named: 'data'),
      queryParameters: any(named: 'queryParameters'),
    ),
  ).thenAnswer(
    (invocation) => Future.value(
      Response(data: {
        'success': successState,
        'data': {},
        if (!successState) 'message': "Error message",
      }, requestOptions: RequestOptions(path: '')),
    ),
  );
}

void _whenPostThrowException(MockedDio dio) {
  when(
    () => dio.post(
      any(),
      data: any(named: 'data'),
      queryParameters: any(named: 'queryParameters'),
    ),
  ).thenThrow(
    DioError(requestOptions: RequestOptions(path: '')),
  );
}

testSuccess(
  Response response,
) {}
