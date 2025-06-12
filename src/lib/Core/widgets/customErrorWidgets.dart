import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';

/*Yara❤️*/
class CustomErrorWidgets extends StatelessWidget {
  CustomErrorWidgets({super.key, required this.errMessage});
  final String errMessage;
  @override
  Widget build(BuildContext context) {
    return Text(
      errMessage,
      style: Styles.styleText20,
    );
  }
}
