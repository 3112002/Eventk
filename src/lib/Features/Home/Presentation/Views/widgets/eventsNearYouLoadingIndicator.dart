import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class EventsNearYouLoadingIndicator extends StatelessWidget {
  const EventsNearYouLoadingIndicator({super.key});
/*Yara Adel Mohamed EL-Sayed*/
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 9.w, top: 5.h),
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 250.h,
          ),
          child: Column(
            children: [
              Container(
                height: 170.h,
                width: 320.w,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 20.h,
                width: 320.w,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 20.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ],
          )),
    );
  }
}
