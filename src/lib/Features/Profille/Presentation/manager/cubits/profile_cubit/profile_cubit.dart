import 'package:eventk/Core/utils/Profile_Service.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/profile_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService service;
  ProfileCubit({required this.service}) : super(ProfileInitialState());
  Future<void> fetchProfile({bool forceRefresh = false}) async {
    emit(ProfileLoadingState());
    try {
      final profile = await service.fetchProfile();

      emit(ProfileLoadedState(profile));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
