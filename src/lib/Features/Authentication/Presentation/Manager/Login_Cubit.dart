import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Features/Authentication/Data/repos/auth_repo_impl.dart';
import 'package:eventk/Features/Authentication/Domain/Auth_repo.dart';
import 'package:eventk/Features/Authentication/Presentation/Manager/Login_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*Yara Adel*/
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(InitailLoginState());
  final AuthRepo authRepo;
  Login({required String email, required String password}) async {
    await getIt<CacheHelper>().removeData(key: 'isGuest');
    emit(LoadingLoginState());
    final result = await AuthRepoImpl()
        .makeRequestForLogin(email: email, password: password);
    result.fold(
      (Failures) => emit(FailarLoginState(Failures.errorMessage)),
      (loginModel) async {
        emit(SuccessLoginState(loginModel));
        await getIt<CacheHelper>()
            .saveData(key: 'token', value: loginModel!.token);
        await getIt<CacheHelper>().saveData(key: 'isLoggedIn', value: true);
        String t = getIt<CacheHelper>().getData(key: 'token') ?? '';
        print(t);
      },
    );
  }
}
