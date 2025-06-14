import 'package:eventk/Core/widgets/custom_fading.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/seeMoreEventsDeatliesLoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Seemoreeventsdetalieslistviewloadingindicator extends StatelessWidget {
  const Seemoreeventsdetalieslistviewloadingindicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFading(
      child: SizedBox(
        height: 300.h,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return SeeMoreEventsDetaliesLoadingIndiactor();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
