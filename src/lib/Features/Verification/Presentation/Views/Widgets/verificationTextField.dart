import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Yara❤️*/

class VerificationTextfields extends StatefulWidget {
  final FocusNode currentNode;
  final FocusNode? nextNode;
  final FocusNode? previousNode;
  final TextEditingController controller;

  VerificationTextfields(
      {required this.currentNode,
      required this.nextNode,
      required this.controller,
      required this.previousNode});

  @override
  State<VerificationTextfields> createState() => _VerificationTextfieldsState();
}

class _VerificationTextfieldsState extends State<VerificationTextfields> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 60.w,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          textInputAction: TextInputAction.next,
          maxLength: 1,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          focusNode: widget.currentNode,
          style: TextStyle(
              color: Colors.black, fontSize: 25.sp, fontFamily: 'bold'),
          onChanged: (value) {
            if (value.length == 1) {
              if (widget.nextNode != null) {
                FocusScope.of(context).requestFocus(widget.nextNode);
              }
            } else if (value.length == 0) {
              if (widget.previousNode != null) {
                FocusScope.of(context).requestFocus(widget.previousNode);
              }
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 15.w,
            ),
            counterText: '',
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: kButtonsColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: kButtonsColor,
                width: 2.w,
              ),
            ),
            filled: true,
            fillColor: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
