import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Features/Verification/Data/Model/Confirm_Email_Model.dart';
import 'package:eventk/Features/Verification/Data/Model/Forget_Password_Model.dart';
import 'package:eventk/Features/Verification/Data/Model/Reset_Password_Model.dart';
import 'package:eventk/Features/Verification/Data/Model/Verify_Email_Model.dart';

/*Yara Adel💕*/
abstract class VerificationRepo {
  Future<Either<Failures, ConfirmEmailModel>> requestForConfirmEmail(
      {required String email, required String otp});
  Future<Either<Failures, ForgetPasswordModel>> requestForForgetPassword(
      {required String email});
  Future<Either<Failures, ResetPasswordModel>> requsertForResetPassword(
      {required String password,
      required String confirmPassword,
      required String email});
  Future<Either<Failures, VerifyEmailModel>> requestForVerifyEmail(
      {required String email, required String otp});
}
