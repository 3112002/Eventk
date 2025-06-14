import 'package:eventk/Core/errors/errorModel.dart';

class AddinterestStates {}

class AddInterestInitialState extends AddinterestStates {}

class AddInterestLoadingState extends AddinterestStates {}

class AddInterestSuccessState extends AddinterestStates {
  final ErrorModel message;
  AddInterestSuccessState(this.message);
}

class AddInterestErrorState extends AddinterestStates {
  final String errorMessage;
  AddInterestErrorState(this.errorMessage);
}

class AddInterestUnAuthorizedState extends AddinterestStates {}
