import 'package:eventk/Features/Profille/Data/models/editProfile_model.dart';
import 'package:eventk/Features/Profille/Data/models/profile_model.dart';

class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profile;
  ProfileLoadedState(this.profile);
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState(this.message);
}

class ProfileUpdating extends ProfileState {}

class EditProfileInitialState extends ProfileState {}

class EditProfileSuccessState extends ProfileState {
  final EditprofileModel editProfileResult;
  EditProfileSuccessState(this.editProfileResult);
}

class EditProfileErrorState extends ProfileState {
  final String message;
  EditProfileErrorState(this.message);
}
