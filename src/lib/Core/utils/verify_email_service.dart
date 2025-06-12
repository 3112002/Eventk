import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/End_Point.dart';
import 'package:eventk/Features/Verification/Data/Model/Verify_Email_Model.dart';

/*Yara Adel Mohamed*/
class VerifyEmailService {
  final Dio dio;
  VerifyEmailService(this.dio);
  Future<VerifyEmailModel> VerifyEmail(
      {required String email, required String otp}) async {
    try {
      Response response =
          await dio.post(EndPoint.baseUrlAuth + EndPoint.verifyEmail,
              data: {
                'email': email,
                'otp': otp,
              },
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
                validateStatus: (status) => status! >= 200 && status < 300,
              ));
      VerifyEmailModel verifyEmailModel =
          VerifyEmailModel.fromJson(response.data);
      return verifyEmailModel;
    } on DioException catch (e) {
      ErrorModel errorModel = ErrorModel.fromJson(e.response!.data);
      final String errorMessage =
          errorModel.message ?? 'oops ,there was an error , try later !';
      throw CustomExceptions(errorMessage);
    } catch (e) {
      throw CustomExceptions((e.toString()));
    }
  }
}
