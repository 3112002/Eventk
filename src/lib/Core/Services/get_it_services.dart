import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/Login_Service.dart';
import 'package:eventk/Features/Authentication/Data/repos/auth_repo_impl.dart';
import 'package:eventk/Features/Authentication/Domain/Auth_repo.dart';
import 'package:eventk/Features/Home/Presentation/repo/home_repo_impl.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:eventk/Features/Intersted/Data/repos/InterestedRepo_impl.dart';
import 'package:eventk/Features/Intersted/Domain/InterestedRepo.dart';
import 'package:eventk/Features/Verification/Domain/ver_repo.dart';
import 'package:eventk/Features/Verification/Presentation/repo/ver_repo_impl.dart';
import 'package:get_it/get_it.dart';

/*Yara❤️*/
final getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerSingleton<LoginService>(LoginService(Dio()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl());
  getIt.registerSingleton<VerificationRepo>(VerificationRepoImpl());
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl());
  getIt.registerSingleton<Interestedrepo>(InterestedrepoImpl());
}
