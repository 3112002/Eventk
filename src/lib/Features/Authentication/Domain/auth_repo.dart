import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Features/Authentication/Data/Model/Login_Model.dart';
import 'package:eventk/Features/Authentication/Data/Model/Signup_Model.dart';

/*Yara❤️*/
abstract class AuthRepo {
  Future<Either<Failures, LoginModel>> makeRequestForLogin(
      {required String email, required String password});
  Future<Either<Failures, SignupModel>> makeRequestForSignup(
      {required String userName,
      required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String birthDate});
}
