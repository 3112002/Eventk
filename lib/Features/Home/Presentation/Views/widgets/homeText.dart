import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

/*Yara Adel*/
class HomeTextHeading extends StatelessWidget {
  const HomeTextHeading({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Row(
        children: [
          Text(
            '$text',
            style: Styles.styleText20,
          ),
          Padding(padding: EdgeInsets.only(left: 8.w)),
          // Icon(
          //   LineIcons.chevronRight,
          //   size: 20,
          // ),
        ],
      ),
    );
  }
}
