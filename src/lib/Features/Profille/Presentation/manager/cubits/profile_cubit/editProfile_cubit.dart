import 'package:eventk/Core/utils/editProfile_service.dart';
import 'package:eventk/Features/Profille/Data/models/profile_model.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/profile_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditprofileCubit extends Cubit<ProfileState> {
  final EditprofileService service;
  final ProfileModel profile;
  EditprofileCubit(this.profile, {required this.service})
      : super(EditProfileInitialState());
  Future<void> editProfile({
    required String firstName,
    required String lastName,
    required String userName,
    required String? bio,
    required String? birthDate,
    String? profilePicturePath,
  }) async {
    emit(ProfileUpdating());
    try {
      final updatedProfile = await service.editProfile(
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        bio: bio ?? "",
        birthDate: birthDate ?? "",
        profilePicPath: profilePicturePath ?? "",
      );
      emit(EditProfileSuccessState(updatedProfile));
    } catch (e) {
      emit(EditProfileErrorState(e.toString()));
    }
  }
}
