import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/End_Point.dart';
import 'package:eventk/Features/Verification/Data/Model/Forget_Password_Model.dart';

/*Yara❤️*/
class ForgetPasswordService {
  final Dio dio;
  ForgetPasswordService(this.dio);
  Future<ForgetPasswordModel> requestForForgetPassword(
      {required String email}) async {
    try {
      Response response =
          await dio.post(EndPoint.baseUrlAuth + EndPoint.forgotPassword,
              data: jsonEncode(email),
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                },
                validateStatus: (status) => status! >= 200 && status < 300,
              ));
      ForgetPasswordModel forgetPasswordModel =
          ForgetPasswordModel.fromJson(response.data);
      return forgetPasswordModel;
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
