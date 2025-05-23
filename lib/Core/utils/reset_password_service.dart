import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/End_Point.dart';
import 'package:eventk/Features/Verification/Data/Model/Reset_Password_Model.dart';

/*Yara❤️*/
class ResetPasswordService {
  final Dio dio;
  ResetPasswordService(this.dio);
  Future<ResetPasswordModel> requestForResetPassword(
      String email, String password, String confirmPassword) async {
    try {
      Response response = await dio.post(
        EndPoint.baseUrlAuth + EndPoint.resetPassword,
        data: {
          'password': password,
          'confirmPassword': confirmPassword,
          'email': email,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! >= 200 && status < 300,
        ),
      );
      ResetPasswordModel resetPasswordModel =
          ResetPasswordModel.fromjson(response.data);
      return resetPasswordModel;
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
