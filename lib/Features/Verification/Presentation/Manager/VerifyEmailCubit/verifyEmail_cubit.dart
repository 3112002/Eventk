import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Verification/Domain/ver_repo.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/VerifyEmailCubit/verifyEmail_state.dart';
import 'package:eventk/Features/Verification/Presentation/repo/ver_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit(this.verificationRepo) : super(InitialVerifyEmailState());
  final VerificationRepo verificationRepo;
  Future<void> VerifyEmail({required String email, required String otp}) async {
    emit(LoadingVerifyEmailState());
    final result = await VerificationRepoImpl()
        .requestForVerifyEmail(email: email, otp: otp);
    result.fold(
        (Failures) => emit(FailureVerifyEmailState(Failures.errorMessage)),
        (VerifyEmailModel) {
      emit(SuccessVerifyEmailState());
      getIt<CacheHelper>().saveData(key: 'verifyEmail', value: email);
    });
  }
}
