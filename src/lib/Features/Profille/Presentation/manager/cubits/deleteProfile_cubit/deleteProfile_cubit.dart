import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/delete_profile_service.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/deleteProfile_cubit/deleteProfile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteprofileCubit extends Cubit<DeleteprofileStates> {
  final DeleteProfileService service;

  DeleteprofileCubit({required this.service})
      : super(DeleteProfileInitailsState());

  Future<void> deleteProfile(String oldPass) async {
    emit(DeleteProfileLoadingState());
    try {
      final deleteProfileModel = await service.deleteProfile(oldPass);
      if (deleteProfileModel.status != "Success") {
        throw CustomExceptions(deleteProfileModel.message);
      }
      await CacheHelper().removeData(key: 'token');
      emit(DeleteProfileSuccessState(deleteProfileModel));
    } on CustomExceptions catch (e) {
      emit(DeleteProfileFailureState(errorMessage: e.message));
    } catch (e) {
      emit(DeleteProfileFailureState(
        errorMessage: 'An unexpected error occurred',
      ));
    }
  }
}
