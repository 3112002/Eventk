import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel*/
class ButtonsText extends StatelessWidget {
  const ButtonsText({required this.text, required this.onPressedCallBack});
  final String text;
  final VoidCallback onPressedCallBack;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressedCallBack();
      },
      child: Text(
        '$text',
        style: TextStyle(color: kButtonsColor, fontSize: 15.sp),
      ),
    );
  }
}
