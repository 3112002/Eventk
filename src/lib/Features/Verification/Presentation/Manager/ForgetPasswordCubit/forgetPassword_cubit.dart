import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Verification/Domain/ver_repo.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/ForgetPasswordCubit/forgetPassword_state.dart';
import 'package:eventk/Features/Verification/Presentation/repo/ver_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*Yara Adel💕*/

class ForgetpasswordCubit extends Cubit<ForgetpasswordState> {
  ForgetpasswordCubit(this.verificationRepo)
      : super(InitialForgetPasswordState());
  VerificationRepo verificationRepo;
  Future<void> ForgetEmail({required String email}) async {
    emit(LoadingForgetPasswordState());
    final result =
        await VerificationRepoImpl().requestForForgetPassword(email: email);
    result.fold(
        (Failures) =>
            emit(FailureForgetPasswordState(errMessage: Failures.errorMessage)),
        (ForgetPasswordModel) {
      emit(SuccessForgetPasswordState());
      getIt<CacheHelper>().saveData(key: 'forgetEmail', value: email);
    });
  }
}
