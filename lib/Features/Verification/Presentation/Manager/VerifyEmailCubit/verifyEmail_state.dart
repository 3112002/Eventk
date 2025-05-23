abstract class VerifyEmailState {}

class InitialVerifyEmailState extends VerifyEmailState {}

class SuccessVerifyEmailState extends VerifyEmailState {}

class LoadingVerifyEmailState extends VerifyEmailState {}

class FailureVerifyEmailState extends VerifyEmailState {
  String errMessage;
  FailureVerifyEmailState(this.errMessage);
}
