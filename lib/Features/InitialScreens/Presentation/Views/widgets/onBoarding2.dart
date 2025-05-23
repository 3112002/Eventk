import 'package:eventk/constants.dart';
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Core/widgets/buttons.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara❤️*/
class OnBoardingPage2 extends StatelessWidget {
  const OnBoardingPage2({super.key});

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
            ),
            Padding(padding: EdgeInsets.only(top: 30.h)),
            Image.asset(
              AssestsImages.onBoarding2Text,
              width: 359.14.w,
              height: 144.4.h,
            ),
            Padding(padding: EdgeInsets.only(top: 30.h)),
            Buttons(
                text: 'Get Started',
                onPressedCallBack: () async {
                  Navigator.pushReplacementNamed(context, LoginPage.id);
                }),
          ],
        ),
      ),
    );
  }
}
