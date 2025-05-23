import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara❤️*/
class CustomLoadingWidgets extends StatelessWidget {
  const CustomLoadingWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Center(
          child: CircularProgressIndicator(
        color: kButtonsColor,
      )),
    );
  }
}
