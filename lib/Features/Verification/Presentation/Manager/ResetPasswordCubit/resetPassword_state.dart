/*Yara Adel💕*/
abstract class ResetPasswordState {}

class InitialResetPasswordState extends ResetPasswordState {}

class SuccessResetPasswordState extends ResetPasswordState {}

class LoadingResetPasswordState extends ResetPasswordState {}

class FailureResetPasswordState extends ResetPasswordState {
  String errorMessage;
  FailureResetPasswordState(this.errorMessage);
}
