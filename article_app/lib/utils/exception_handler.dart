import 'package:dio/dio.dart';
import 'package:get/get.dart';

class APIException implements Exception {
  final String message;

  APIException({required this.message});
}

class ExceptionHandler {
  ExceptionHandler._privateConstructor();

  static APIException handleError(Exception error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.sendTimeout:
          return APIException(message: 'No Internet');
        case DioExceptionType.connectionTimeout:
          return APIException(message: 'Connection Timeout');
        case DioExceptionType.badResponse:
          print(error.error);
          return APIException(
            message: error.response?.data['Message'] ?? 'Bad Response',
          );
        default:
          return APIException(message: 'Something went wrong');
      }
    } else {
      return APIException(message: 'Something went wrong');
    }
  }
}
