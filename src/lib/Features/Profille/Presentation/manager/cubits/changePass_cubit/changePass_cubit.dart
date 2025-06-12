import 'package:eventk/Core/utils/change_password_service.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/changePass_cubit/changePass_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangepasswordCubit extends Cubit<ChangepasswordStates> {
  final ChangepasswordService service;
  ChangepasswordCubit({required this.service})
      : super(ChangepasswordInitialState());
  Future<void> changePass(
      String oldPass, String newPass, String confirmPass) async {
    emit(ChangepasswordLoadingState());
    try {
      final changepassmodel =
          await service.changePass(oldPass, newPass, confirmPass);
      emit(ChangePasswordSuccessState(changepasswordmodel: changepassmodel));
    } catch (e) {
      emit(ChangePasswordFailureState(errorMessage: e.toString()));
    }
  }
}
