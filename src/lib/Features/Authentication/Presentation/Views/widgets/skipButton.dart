import 'package:eventk/Core/widgets/navigationHome.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Skipbutton extends StatelessWidget {
  const Skipbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.h,
      right: 20.w,
      child: GestureDetector(
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('showSkip', true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => NavigationHomePage()),
          );
        },
        child: Image.asset(
          'assets/Images/skip.png',
          width: 101.w,
          height: 101.h,
        ),
        // child: Container(
        //   padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        //   decoration: BoxDecoration(
        //     color: kButtonsColor.withOpacity(0.1),
        //     borderRadius: BorderRadius.circular(20.r),
        //     border: Border.all(color: kButtonsColor),
        //   ),
        //   child: Text(
        //     "Skip",
        //     style: TextStyle(
        //       color: kButtonsColor,
        //       fontSize: 16.sp,
        //       fontWeight: FontWeight.bold,
        //       letterSpacing: 0.5,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
