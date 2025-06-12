/*Yara Adel💕*/
import 'package:eventk/Features/Verification/Domain/ver_repo.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/ResetPasswordCubit/resetPassword_state.dart';
import 'package:eventk/Features/Verification/Presentation/repo/ver_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.verificationRepo)
      : super(InitialResetPasswordState());
  final VerificationRepo verificationRepo;
  Future<void> ResetPassword(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    emit(LoadingResetPasswordState());
    final result = await VerificationRepoImpl().requsertForResetPassword(
        password: password, confirmPassword: confirmPassword, email: email);
    result.fold(
        (Failures) => emit(FailureResetPasswordState(Failures.errorMessage)),
        (ResetPasswordModel) => emit(SuccessResetPasswordState()));
  }
}
