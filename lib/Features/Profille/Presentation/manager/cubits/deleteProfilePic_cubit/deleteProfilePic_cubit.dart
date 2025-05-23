import 'package:eventk/Core/utils/deleteProfilePic_service.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/deleteProfilePic_cubit/deleteProfilePic_states';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteprofilepicCubit extends Cubit<DeleteprofilepicStates> {
  final DeleteprofilepicService service;
  DeleteprofilepicCubit({required this.service})
      : super(DeleteProfilePicInitialState());
  Future<void> deletePrfilePic() async {
    emit(DeleteProfilePicLoadingState());
    try {
      final result = await service.deleteProfilePic();
      emit(DeleteProfilePicSuccessState(result));
    } catch (e) {
      emit(DeleteProfilePicFailureState(e.toString()));
    }
  }
}
