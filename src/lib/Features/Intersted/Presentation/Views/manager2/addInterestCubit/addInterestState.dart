import 'package:eventk/Features/Intersted/Data/Models/addInterestMode.dart';

abstract class AddInterestState {}

class InitialAddInterestState extends AddInterestState {}

class SuccessAddInterestState extends AddInterestState {
  AddInterestmodel added;
  SuccessAddInterestState(this.added);
}

class FailureAddInterestState extends AddInterestState {
  String errorMessage;
  FailureAddInterestState(this.errorMessage);
}

class LoadingAddInterestState extends AddInterestState {}
