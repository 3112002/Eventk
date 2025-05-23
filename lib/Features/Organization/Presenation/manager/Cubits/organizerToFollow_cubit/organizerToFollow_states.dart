import 'package:eventk/Features/Organization/Data/models/OrganizationToFollowModel.dart';

class OrganizationsToFollowState {}

class OrganizationsToFollowInitialState extends OrganizationsToFollowState {}

class OrganizationsToFollowLoadingState extends OrganizationsToFollowState {}

class OrganizationsToFollowFailureState extends OrganizationsToFollowState {
  final String errorMessage;
  OrganizationsToFollowFailureState(this.errorMessage);
}

class OrganizationsToFollowSuccessState extends OrganizationsToFollowState {
  final List<Organizationtofollowmodel> organizations;
  OrganizationsToFollowSuccessState(this.organizations);
}
