/*Yara Adel💕*/
abstract class ConfirmEmailState {}

class InitialStateConfirmEmail extends ConfirmEmailState {}

class SuccessStateConfirmEmail extends ConfirmEmailState {}

class FailureStateConfirmEmail extends ConfirmEmailState {
  String errMeassage;
  FailureStateConfirmEmail(this.errMeassage);
}

class LoadingStateConfirmEmail extends ConfirmEmailState {}
