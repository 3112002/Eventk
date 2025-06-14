import 'package:eventk/Features/InitialScreens/Presentation/Views/widgets/onBoarding2.dart';
import 'package:eventk/Features/InitialScreens/Presentation/Views_Models/onBoarding1Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
class Onboarding1 extends StatelessWidget {
 
  final OnBoardingData boarding1 = const OnBoardingData(
      image: "assets/images/ConvOnboarding1.png",
    title: "Easy To Find Events",
    description: "Discover a variety of events tailored to your interests. our platform makes it simple to browse and find what matters most to you.",
  );
const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color(0xffF7F8FA),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 320.w,
                height: 330.59.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(boarding1.image), // the outer image 
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                      "assets/Images/CirclesOnboarding1.png", // the inner image
                    height: 450.h,
                    width: 340.w,
                  ),
                ),
              ),
              SizedBox(height: 25.h), 
              Container(
                height: 39.h,
                width: 254.w,
                child: Text(
                  boarding1.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter"
                  ),
                ),
              ),
             SizedBox(height: 8.h),
              Container(
                height: 72.h,
                width: 359.14.w,
                child: Text(
                  boarding1.description,
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    color: const Color(0xff000000),
                    fontSize: 16.sp,
                    fontFamily: "Inter",
                  ),
                ),
              ),
              SizedBox(height: 15.h,),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: (){
                    
                    
                    Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Onboarding2()),
            );
                   
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, 
                    elevation: 0, 
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  ),
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Next",
                        style: TextStyle(
                          color: const Color(0xff1D61E7),
                          fontSize: 20.sp,
                          fontFamily: "Inter",
                        ),
                      ),
                      SizedBox(width: 8.w),
                      
                      Icon(
                        Icons.arrow_forward,
                        color: const Color(0xff1D61E7),
                        size: 30.sp,
                      ),
                    ],
                  ),
                  ),
              ),
            ],
          
          ),
        ),
      ),
      
    );
  }
}
