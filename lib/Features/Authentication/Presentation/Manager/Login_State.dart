/*Yara Adel*/
import 'package:eventk/Features/Authentication/Data/Model/Login_Model.dart';

abstract class LoginState {}

class InitailLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  LoginModel loginModel;
  SuccessLoginState(this.loginModel);
}

class LoadingLoginState extends LoginState {}

class FailarLoginState extends LoginState {
  final String errorMessage;
  FailarLoginState(this.errorMessage);
}
