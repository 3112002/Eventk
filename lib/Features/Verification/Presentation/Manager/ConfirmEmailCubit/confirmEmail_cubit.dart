import 'package:eventk/Features/Verification/Domain/ver_repo.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/ConfirmEmailCubit/confirmEmail_state.dart';
import 'package:eventk/Features/Verification/Presentation/repo/ver_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*Yara Adel💕*/
class ConfirmemailCubit extends Cubit<ConfirmEmailState> {
  ConfirmemailCubit(this.verificationRepo) : super(InitialStateConfirmEmail());
  final VerificationRepo verificationRepo;
  Future<void> ConfirmEmail(
      {required String email, required String otp}) async {
    emit(LoadingStateConfirmEmail());
    final result = await VerificationRepoImpl()
        .requestForConfirmEmail(email: email, otp: otp);
    result.fold(
      (Failures) => emit(FailureStateConfirmEmail(Failures.errorMessage)),
      (ConfirmEmailModel) => emit(SuccessStateConfirmEmail()),
    );
  }
}
