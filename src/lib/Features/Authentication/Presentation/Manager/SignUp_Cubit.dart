import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Features/Authentication/Data/repos/auth_repo_impl.dart';

import 'package:eventk/Features/Authentication/Domain/Auth_repo.dart';
import 'package:eventk/Features/Authentication/Presentation/Manager/SignUp_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*Yara❤️*/

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(InitalSignupState());
  final AuthRepo authRepo;
  SignUp(
      {required String userName,
      required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String birthDate}) async {
    emit(LoadingSignupState());
    final result = await AuthRepoImpl().makeRequestForSignup(
        userName: userName,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate);

    result.fold((Failures) => emit(FailureSignupState(Failures.toString())),
        (signupModel) async {
      emit(SuccessSignupState());

      getIt<CacheHelper>().saveData(key: 'email', value: email);
      getIt<CacheHelper>().saveData(key: 'userName', value: userName);
      getIt<CacheHelper>().saveData(key: 'firstName', value: firstName);
      getIt<CacheHelper>().saveData(key: 'lastName', value: lastName);
      getIt<CacheHelper>().saveData(key: 'birthDate', value: birthDate);
      getIt<CacheHelper>().saveData(key: 'password', value: password);
    });
  }
}
