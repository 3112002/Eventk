import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/tabBarIntersed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intersetallpage extends StatelessWidget {
  const Intersetallpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        automaticallyImplyLeading: false,
        flexibleSpace: Image.asset(
          AssestsImages.backgroundEvents,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        title: Text(
          "Events that You're Interested In",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Tabbarintersed(),
    );
  }
}
