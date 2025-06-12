import 'package:dio/dio.dart';
import 'package:eventk/Core/utils/Profile_Service.dart';
import 'package:eventk/Core/utils/deleteProfilePic_service.dart';
import 'package:eventk/Features/Profille/Presentation/Views/widgets/profile_body.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/profile_cubit/profile_cubit.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/deleteProfilePic_cubit/deleteProfilePic_cubit.dart';
import 'package:eventk/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*Yara Adel Mohamed*/
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            ProfileCubit(service: ProfileService(api: Api(dio: Dio()))),
      ),
      BlocProvider(
        create: (context) => DeleteprofilepicCubit(
            service: DeleteprofilepicService(api: Api(dio: Dio()))),
      )
    ], child: ProfileBody());
  }
}
