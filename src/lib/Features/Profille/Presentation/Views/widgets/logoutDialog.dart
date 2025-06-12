import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logoutdialog extends StatefulWidget {
  const Logoutdialog({super.key});

  @override
  State<Logoutdialog> createState() => _LogoutdialogState();
}

class _LogoutdialogState extends State<Logoutdialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 61.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xffE2E2E2),
          width: 2.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15.w),
          const Icon(Icons.logout),
          SizedBox(width: 20.w),
          Text(
            "Logout",
            style: TextStyle(
              color: const Color(0xff000000),
              fontSize: 16.sp,
              fontFamily: "Jakarta",
              fontWeight: FontWeight.bold,
              height: 0.963.h,
            ),
          ),
        ],
      ),
    );
  }
}
