import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel*/
class Heading extends StatelessWidget {
  final String? htext;
  const Heading(this.htext);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          this.htext!,
          style: TextStyle(
            fontFamily: 'bold',
            fontSize: 15.sp,
            color: Colors.black,
          ),
        ),
        Icon(
          Icons.navigate_next,
          size: 17.sp,
        ),
      ],
    );
  }
}
