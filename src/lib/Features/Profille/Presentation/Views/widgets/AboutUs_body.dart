import 'package:eventk/Core/widgets/CustomAppBar.dart';
import 'package:eventk/Features/Profille/Presentation/Views/widgets/BluePoint.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'About Eventk'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.w),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.celebration, color: kButtonsColor, size: 28.sp),
                    SizedBox(width: 8.w),
                    Text(
                      "Welcome to Eventk",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: <Color>[
                              kButtonsColor,
                              Colors.deepPurpleAccent
                            ],
                          ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Text(
                  "Your go-to platform for discovering and managing events around you.",
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "✨ With Eventk, you can:",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  "🔍 Discover Events",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.h),
                const BulletPoint(
                    text: "Browse events by category, location, or date."),
                const BulletPoint(
                    text: "Filter events based on your interests."),
                const BulletPoint(
                    text: "View detailed event information and media."),
                const BulletPoint(
                    text: "Discover trending and recommended events."),
                const BulletPoint(
                    text: "Use smart search to find events faster."),
                const BulletPoint(
                    text: "Explore events happening near your location."),
                const BulletPoint(
                    text:
                        "Access curated collections for holidays and seasons."),
                SizedBox(height: 20.h),
                Text(
                  "👥 Social & Community",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.h),
                const BulletPoint(text: "Follow your favorite organizers."),
                const BulletPoint(
                    text: "View organizer profiles and their events."),
                SizedBox(height: 20.h),
                Text(
                  "🎟 Ticketing & Planning",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.h),
                const BulletPoint(text: "Book tickets quickly and securely."),
                const BulletPoint(
                    text: "Access both free and paid events seamlessly."),
                const BulletPoint(
                    text: "Stay organized with your personalized list."),
                const BulletPoint(
                    text: "Receive real-time updates and event reminders."),
                const BulletPoint(
                    text: "Save events to your calendar with one tap."),
                const BulletPoint(
                    text: "Track your ticket history and upcoming events."),
                const BulletPoint(
                    text: "Get instant confirmation and e-tickets."),
                const BulletPoint(
                    text: "Manage ticket quantities and preferences easily."),
                const BulletPoint(text: "Request refunds for eligible events."),
                const BulletPoint(
                    text: "Enjoy a smooth check-in experience with QR codes."),
                SizedBox(height: 24.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: kButtonsColor.withOpacity(0.2)),
                  ),
                  padding: EdgeInsets.all(14.w),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb_rounded, color: kButtonsColor),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "Our mission is to help you explore, connect, and enjoy meaningful experiences.",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
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
