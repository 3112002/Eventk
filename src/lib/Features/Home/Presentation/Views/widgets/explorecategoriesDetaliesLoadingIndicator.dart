import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExplorecategoriesDetaliesLoadingIndicator extends StatelessWidget {
  const ExplorecategoriesDetaliesLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.sp,
          width: 100.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            color: Colors.grey,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20.h)),
        Container(
          height: 10.sp,
          width: 100.sp,
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
