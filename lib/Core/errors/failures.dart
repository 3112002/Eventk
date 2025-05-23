import 'package:dio/dio.dart';

/*Yara❤️*/
abstract class Failures {
  final String errorMessage;
  const Failures(this.errorMessage);
}

class ServerFailure extends Failures {
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiSever');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiSever');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiSever');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate timeout with ApiSever');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Reqest was Canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection error');
      case DioExceptionType.unknown:
        return ServerFailure('Unexpected error, please try later !');
    }
  }
  factory ServerFailure.fromResponse(int responseCode, dynamic response) {
    if (responseCode == 400 || responseCode == 401 || responseCode == 403) {
      return ServerFailure(response['message']);
    } else if (responseCode == 404) {
      return ServerFailure('Your request not found, please try later !');
    } else if (responseCode == 500) {
      return ServerFailure('Internal server error, please try later !');
    } else {
      return ServerFailure('Oops there was an error,  please try later !');
    }
  }
}
