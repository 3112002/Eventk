import 'package:eventk/Core/widgets/CustomAppBar.dart';
import 'package:eventk/Features/Profille/Presentation/Views/widgets/BluePoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'About Us',),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to Eventk 🎉",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Your go-to platform for discovering and managing events around you.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "With Eventk, you can:",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                const BulletPoint(text: "Browse events by category, location, or date."),
                const BulletPoint(text: "Follow your favorite organizers."),
                const BulletPoint(text: "Book tickets quickly and securely."),
                const BulletPoint(text: "Stay organized with your personalized list."),
                SizedBox(height: 20.h),
                Text(
                  "Our mission is to help you explore, connect, and enjoy meaningful experiences.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
