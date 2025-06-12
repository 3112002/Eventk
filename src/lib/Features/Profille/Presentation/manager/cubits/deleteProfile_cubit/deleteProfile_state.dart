import 'package:eventk/Features/Profille/Data/models/deleteProfile_model.dart';

class DeleteprofileStates {}

class DeleteProfileInitailsState extends DeleteprofileStates {}

class DeleteProfileLoadingState extends DeleteprofileStates {}

class DeleteProfileSuccessState extends DeleteprofileStates {
  final DeleteprofileModel deleteprofilemodel;
  DeleteProfileSuccessState(this.deleteprofilemodel);
}

class DeleteProfileFailureState extends DeleteprofileStates{
  final String errorMessage;
  DeleteProfileFailureState({required this.errorMessage});
}
