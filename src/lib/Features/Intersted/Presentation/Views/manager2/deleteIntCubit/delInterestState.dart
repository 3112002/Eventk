import 'package:eventk/Features/Intersted/Data/Models/addInterestMode.dart';

abstract class DeleInterestState {}

class InitialDelInterestState extends DeleInterestState {}

class SuccessDelInterestState extends DeleInterestState {
  AddInterestmodel added;
  SuccessDelInterestState(this.added);
}

class FailureDelInterestState extends DeleInterestState {
  String errorMessage;
  FailureDelInterestState(this.errorMessage);
}

class LoadingDelInterestState extends DeleInterestState {}
