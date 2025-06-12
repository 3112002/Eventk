import 'package:eventk/Features/Home/Data/model/locationModel.dart';

/*Yara Adel Mohamed*/
abstract class GetLocationState {}

class InitialGetLocationState extends GetLocationState {}

class FailureGetLocationState extends GetLocationState {
  String errMessage;
  FailureGetLocationState(this.errMessage);
}

class LoadingGetLocationState extends GetLocationState {}

class SuccessGetLocationState extends GetLocationState {
  LocationModel locationModel;
  SuccessGetLocationState(this.locationModel);
}
