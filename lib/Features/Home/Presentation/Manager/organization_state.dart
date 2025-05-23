import 'package:eventk/Features/Home/Data/model/organizationModel.dart';

/*Yara Adel Mohamed*/
abstract class OrganizationState {}

class InitialOrganizationState extends OrganizationState {}

class SuccessOrganizationState extends OrganizationState {
  final List<OrganizationModel> organizationList;
  SuccessOrganizationState(this.organizationList);
}

class LoadingOrganizationState extends OrganizationState {}

class FailureOrganizationState extends OrganizationState {
  String errMessage;
  FailureOrganizationState(this.errMessage);
}
