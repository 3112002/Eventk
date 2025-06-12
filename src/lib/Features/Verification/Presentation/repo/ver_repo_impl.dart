import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/confirm_email_service.dart';
import 'package:eventk/Core/utils/forget_password_service.dart';
import 'package:eventk/Core/utils/reset_password_service.dart';
import 'package:eventk/Core/utils/verify_email_service.dart';
import 'package:eventk/Features/Verification/Data/Model/Confirm_Email_Model.dart';
import 'package:eventk/Features/Verification/Data/Model/Forget_Password_Model.dart';
import 'package:eventk/Features/Verification/Data/Model/Reset_Password_Model.dart';
import 'package:eventk/Features/Verification/Data/Model/Verify_Email_Model.dart';
import 'package:eventk/Features/Verification/Domain/ver_repo.dart';

/*Yara Adel💕*/
class VerificationRepoImpl extends VerificationRepo {
  @override
  Future<Either<Failures, ConfirmEmailModel>> requestForConfirmEmail(
      {required String email, required String otp}) async {
    try {
      var confirm = await ConfirmEmailService(Dio())
          .requestForVreification(email: email, otp: otp);
      return right(confirm!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, ForgetPasswordModel>> requestForForgetPassword(
      {required String email}) async {
    try {
      var exitEmail = await ForgetPasswordService(Dio())
          .requestForForgetPassword(email: email);
      return right(exitEmail!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, VerifyEmailModel>> requestForVerifyEmail(
      {required String email, required String otp}) async {
    try {
      var verify =
          await VerifyEmailService(Dio()).VerifyEmail(email: email, otp: otp);
      return right(verify!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, ResetPasswordModel>> requsertForResetPassword(
      {required String password,
      required String confirmPassword,
      required String email}) async {
    try {
      var result = await ResetPasswordService(Dio())
          .requestForResetPassword(email, password, confirmPassword);
      return right(result!);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
