import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel*/

class Biotextfield extends StatefulWidget {
  TextEditingController BioCont = TextEditingController();
  Biotextfield({required this.BioCont});
  @override
  State<Biotextfield> createState() => _BiotextfieldState();
}

class _BiotextfieldState extends State<Biotextfield> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 290.w,
        child: TextFormField(
          controller: widget.BioCont,
          maxLength: 30,
          style: TextStyle(
              color: Colors.black, fontSize: 15.sp, fontFamily: 'bold'),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.0.h,
              horizontal: 9.0.w,
            ),
            border: const OutlineInputBorder(),
            labelText: 'Bio',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kButtonsColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kButtonsColor,
                width: 2.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)).w,
            ),
            floatingLabelStyle: const TextStyle(
              color: kButtonsColor,
            ),
            hintText: 'Say somthing about yourself',
          ),
        ),
      ),
    );
  }
}
