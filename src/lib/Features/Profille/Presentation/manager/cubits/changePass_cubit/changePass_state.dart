import 'package:eventk/Features/Profille/Data/models/change_password.dart';

class ChangepasswordStates {}

class ChangepasswordInitialState extends ChangepasswordStates {}

class ChangepasswordLoadingState extends ChangepasswordStates {}

class ChangePasswordSuccessState extends ChangepasswordStates {
  final ChangepasswordModel changepasswordmodel;
  ChangePasswordSuccessState({required this.changepasswordmodel});
}

class ChangePasswordFailureState extends ChangepasswordStates {
  final String errorMessage;
  ChangePasswordFailureState({required this.errorMessage});
}
