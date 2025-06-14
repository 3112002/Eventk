import 'package:eventk/Core/Services/get_it_services.dart';

import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/customErrorWidgets.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_location_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_location_state.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TurnOnLocation extends StatefulWidget {
  const TurnOnLocation({super.key});

  @override
  State<TurnOnLocation> createState() => _TurnOnLocationState();
}

class _TurnOnLocationState extends State<TurnOnLocation> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetLocationCubit(getIt<HomeRepo>()),
      child: BlocBuilder<GetLocationCubit, GetLocationState>(
        builder: (context, state) {
          if (state is SuccessGetLocationState ||
              state is InitialGetLocationState) {
            return Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10.h)),
                Icon(
                  Icons.location_off,
                  color: Colors.blue,
                  size: 100,
                ),
                Padding(padding: EdgeInsets.only(top: 10.h)),
                Text(
                  'Turn on you location to explore events by distance',
                  style: Styles.styleText15,
                ),
                Padding(padding: EdgeInsets.only(top: 30.h)),
                ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<GetLocationCubit>(context).GetLoaction();

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Get Current Location",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            );
          } else if (state is FailureGetLocationState) {
            return CustomErrorWidgets(
                errMessage:
                    'This feature requires access to your location, Please enable location permission in your device settings');
          } else {
            return CustomLoadingWidgets();
          }
        },
      ),
    );
  }
}
