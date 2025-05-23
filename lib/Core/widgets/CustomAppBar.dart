import 'package:eventk/Core/utils/assests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});
  @override
  Size get preferredSize => Size.fromHeight(80.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80.h,
      automaticallyImplyLeading: false,
      flexibleSpace: Image(
        image: AssetImage(AssestsImages.backgroundEvents),
        fit: BoxFit.cover,
      ),
      title: Padding(
          padding: EdgeInsets.only(bottom: 60.h),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
