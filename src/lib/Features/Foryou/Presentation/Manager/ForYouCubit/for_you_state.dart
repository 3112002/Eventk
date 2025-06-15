import 'package:eventk/Features/Foryou/Data/Model/for_you_model/for_you_model.dart';
import 'package:eventk/Features/Foryou/Data/Model/for_you_model/recommended_event.dart';

abstract class GetForYouState {}

class InitialGetForYouEvents extends GetForYouState {}

class SuccessGetForYouState extends GetForYouState {
  ForYouModel forYouModel;
  SuccessGetForYouState(this.forYouModel);
}

class LoadingGetForYouState extends GetForYouState {}

class FailureGetForYouState extends GetForYouState {
  String errorMessage;
  FailureGetForYouState(this.errorMessage);
}
