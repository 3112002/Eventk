import 'package:eventk/Core/errors/errorModel.dart';

class DeleteInterestStates{}
class DeleteInterestInitialState extends DeleteInterestStates{}
class DeleteInterestLoadingState extends DeleteInterestStates{}
class DeleteInterestSuccessState extends DeleteInterestStates{
  final ErrorModel message;
  DeleteInterestSuccessState(this.message);
}
class DeleteInterestErrorState extends DeleteInterestStates{
  final String errorMessage;
  DeleteInterestErrorState(this.errorMessage);
}