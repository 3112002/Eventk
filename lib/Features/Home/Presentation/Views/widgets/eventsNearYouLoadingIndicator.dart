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
        child: Stack(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 320.w,
                  height: 250.h,
                ),
                Positioned(
                  bottom: 80.h,
                  left: 0.w,
                  child: Container(
                    height: 170.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30.h,
                  child: Container(
                    width: 320.w,
                    height: 75.h,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20.w,
                          height: 10.h,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 10.h,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 265.w,
                  bottom: 90.h,
                  child: Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[350],
                      ),
                      child: RiveAnimatedIcon(
                        riveIcon: RiveIcon.star,
                        width: 12.w,
                        height: 12.h,
                        color: Colors.grey,
                        strokeWidth: 3,
                        loopAnimation: false,
                        onTap: () {},
                        onHover: (value) {},
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
