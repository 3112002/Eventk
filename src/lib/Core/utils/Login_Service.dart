import 'package:dio/dio.dart';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/End_Point.dart';
import 'package:eventk/Features/Authentication/Data/Model/Login_Model.dart';

/*Yara Adel❤️*/
class LoginService {
  final Dio dio;
  LoginService(this.dio);
  Future<LoginModel?> requsetForLogin(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(EndPoint.baseUrlAuth + EndPoint.login,
          data: {
            'emailOrUsername': email,
            'password': password,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
            validateStatus: (status) => status! >= 200 && status < 300,
          ));
      LoginModel loginModel = LoginModel.fromJson(response.data);
      return (loginModel);
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
