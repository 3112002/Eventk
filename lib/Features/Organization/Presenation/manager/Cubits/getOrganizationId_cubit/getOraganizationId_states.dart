import 'package:eventk/Features/Organization/Data/models/getOrganizationId_model.dart';

class GetoraganizationidStates {}

class GetoraganizationidInitialState extends GetoraganizationidStates {}

class GetoraganizationidLoadingState extends GetoraganizationidStates {}

class GetoraganizationidSuccessState extends GetoraganizationidStates {
  final GetorganizationByIdModel organzation;
  GetoraganizationidSuccessState(this.organzation);
}

class GetoraganizationidFailureState extends GetoraganizationidStates {
  final String message;
  GetoraganizationidFailureState(this.message);
}
