/*Yara❤️*/
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/Login_Service.dart';
import 'package:eventk/Core/utils/Signup_Service.dart';
import 'package:eventk/Features/Authentication/Data/Model/Login_Model.dart';
import 'package:eventk/Features/Authentication/Data/Model/Signup_Model.dart';
import 'package:eventk/Features/Authentication/Domain/Auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failures, LoginModel>> makeRequestForLogin(
      {required String email, required String password}) async {
    try {
      var user = await LoginService(Dio())
          .requsetForLogin(email: email, password: password);
      if (user == null) {
        return left(ServerFailure("Login response was null"));
      }

      return right(user);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, SignupModel>> makeRequestForSignup(
      {required String userName,
      required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String birthDate}) async {
    try {
      var user = await SignupService(Dio()).requestForSignup(
          userName: userName,
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          birthDate: birthDate);
      return right(user!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
