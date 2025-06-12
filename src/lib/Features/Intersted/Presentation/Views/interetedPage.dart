import 'package:dio/dio.dart';
import 'package:eventk/Core/utils/get_Interest_service.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/InterestedBody.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/getInterest_cubit/getInterest_cubit.dart';
import 'package:eventk/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends StatelessWidget {
  static String id = 'InterestedPage';
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>GetinterestCubit(service: GetInterestService(api: Api(dio: Dio())))
          ),
      ],
      child: Interestedbody()
      );
  }
}
