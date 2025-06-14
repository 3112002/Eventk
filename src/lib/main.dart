import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/utils/AuthProvider.dart';
import 'package:eventk/Core/utils/addInterest_service.dart';
import 'package:eventk/Core/utils/categories_service.dart';
import 'package:eventk/Core/utils/deleteInterest_service.dart';
import 'package:eventk/Core/utils/getOrganizationById_service.dart';
import 'package:eventk/Core/widgets/navigationHome.dart';
import 'package:eventk/Features/Foryou/Presentation/Views/forYouPage.dart';
import 'package:eventk/Features/Home/Presentation/Manager/category_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/organization_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Views/allEventsPage.dart';
import 'package:eventk/Features/Home/Presentation/Views/categoreDeatlis.dart';
import 'package:eventk/Features/Home/Presentation/Views/homePage.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/signupPage.dart';
import 'package:eventk/Features/Home/Presentation/Views/orgainzationHome.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/organizationDetalies.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:eventk/Features/InitialScreens/Presentation/Views/widgets/InitialScreen.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/interetedPage.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/deleteInterest_cubit/deleteInterest_cubit.dart';
import 'package:eventk/Features/Organization/Data/repos/OrganizationRepo_Impl.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/follow_unfollow_cubit/follow_unfollow_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/getOrganizationId_cubit/getOrganizationId_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/organizerToFollow_cubit/organizerToFollow_cubit.dart';
import 'package:eventk/Features/Profille/Presentation/Views/changePassword.dart';
import 'package:eventk/Features/Profille/Presentation/Views/deleteProfile.dart';
import 'package:eventk/Features/Verification/Presentation/Views/forgetPassword.dart';
import 'package:eventk/Features/Verification/Presentation/Views/resetPassword.dart';
import 'package:eventk/constants.dart';
import 'package:eventk/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

/*Yara❤️*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CategoriesService(Dio()).requestForCategories();
  setUpServiceLocator();
  await getIt<CacheHelper>().initSharedPreferences();
  runApp(MultiBlocProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => Authprovider(getIt<CacheHelper>()),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    CategoryCubit(getIt<HomeRepo>())..Category(),
              ),
              BlocProvider(
                  create: (context) => OrganizationCubit(getIt<HomeRepo>())
                    ..Organization(isFollowing: true)),
              BlocProvider(
                create: (context) => GetEventsCubit(getIt<HomeRepo>()),
              ),
              BlocProvider(
                create: (context) => AddinterestCubit(
                    service: AddinteretsService(api: Api(dio: Dio()))),
              ),
              BlocProvider(
                create: (context) => DeleteinterestCubit(
                    service: DeleteinterestService(api: Api(dio: Dio()))),
              ),
              BlocProvider(
                create: (context) =>
                    FollowUnfollowCubit(OrganizationrepoImpl()),
              ),
              BlocProvider(
                create: (context) => GetorganizationidCubit(
                    service: GetorganizationbyidService(api: Api(dio: Dio()))),
              ),
              BlocProvider(
                create: (context) =>
                    OrganizertofollowCubit(OrganizationrepoImpl())
                      ..fetchOrganizationsToFollow(isFollowing: false),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Eventk',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: kButtonsColor,
                  selectionColor: const Color.fromARGB(255, 174, 201, 255),
                  selectionHandleColor: kButtonsColor,
                ),
                textTheme:
                    Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
                scaffoldBackgroundColor: const Color(0xFFF7F8FA),
              ),
              routes: {
                LoginPage.id: (context) => LoginPage(),
                SignupPage.id: (context) => SignupPage(),
                HomePage.id: (context) => HomePage(),
                NavigationHomePage.id: (context) => NavigationHomePage(),
                ForgetPassword.id: (context) => ForgetPassword(),
                ResetPassword.id: (context) => ResetPassword(),
                DeleteProfile.id: (context) => DeleteProfile(),
                ChangePassword.id: (context) => ChangePassword(),
                CategoreDeatlis.id: (context) => CategoreDeatlis(),
                FavouritesPage.id: (context) => FavouritesPage(),
                ForYouPage.id: (context) => ForYouPage(),
                OrgainzationHome.id: (context) => OrgainzationHome(),
                OrganizationDetalies.id: (context) => OrganizationDetalies(),
                /*
                Signinrequiredpage.id: (context) {
                  final args = ModalRoute.of(context)!.settings.arguments
                      as Map<String, String>;
                  return Signinrequiredpage(
                    message: args['message'] ?? 'Please sign in.',
                    title: args['title'] ?? 'Sign In Required',
                  );
                },
                */
              },
              home: LoginPage(),
              //NavigationHomePage(),
            ));
      },
    );
  }
}
