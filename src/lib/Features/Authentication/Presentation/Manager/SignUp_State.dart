/*Yara❤️*/
abstract class SignupState {}

class InitalSignupState extends SignupState {}

class SuccessSignupState extends SignupState {}

class LoadingSignupState extends SignupState {}

class FailureSignupState extends SignupState {
  final String errMessage;
  FailureSignupState(this.errMessage);
}
