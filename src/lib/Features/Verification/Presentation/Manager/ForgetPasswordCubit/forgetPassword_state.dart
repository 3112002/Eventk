/*Yara Adel💕*/

abstract class ForgetpasswordState {}

class InitialForgetPasswordState extends ForgetpasswordState {}

class SuccessForgetPasswordState extends ForgetpasswordState {}

class LoadingForgetPasswordState extends ForgetpasswordState {}

class FailureForgetPasswordState extends ForgetpasswordState {
  final String errMessage;
  FailureForgetPasswordState({required this.errMessage});
}
