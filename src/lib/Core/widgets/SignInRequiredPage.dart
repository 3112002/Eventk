import 'package:eventk/Core/widgets/CustomAppBar.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signinrequiredpage extends StatelessWidget {
  static const String id = 'SignInRequiredPage';
  final String message;
  final String title;
  const Signinrequiredpage(
      {super.key, required this.message, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/Images/shouldSignIn.png",
              width: 250.w,
              //height: 150.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, color: Colors.black),
            ),
            SizedBox(
              height: 30.h,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, LoginPage.id);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: kButtonsColor,
                  elevation: 5,
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
