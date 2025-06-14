import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

/*Yara❤️*/
class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 60.h)),
            SizedBox(
              height: 316.h,
              child: Stack(
                children: [
                  Positioned(
                    left: 10.w,
                    width: 340.w,
                    height: 340.h,
                    child: Image.asset(AssestsImages.onBoarding2Circles),
                  ),
                  Positioned(
                    top: 8.h,
                    left: 42.5.w,
                    width: 280.w,
                    height: 316.h,
                    child: Image.asset(AssestsImages.onBoarding2Illustration),
                  ),
                ],
              ),
              // Non-positioned image outside the Stack
            ),
            Padding(padding: EdgeInsets.only(top: 30.h)),
            Image.asset(
              AssestsImages.onBoarding2Text,
              width: 359.14.w,
              height: 144.4.h,
            ),
            Padding(padding: EdgeInsets.only(top: 30.h)),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(300.w, 55.h)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(kPrimaryColor),
              ),
              onPressed: () async {
                await getIt<CacheHelper>()
                    .saveData(key: 'showHome', value: true);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                ' Get Started ',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color.fromARGB(255, 253, 253, 253),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
