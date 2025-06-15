import 'package:eventk/Core/widgets/custom_fading.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/eventsNearYouLoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel Mohamed EL-Sayed*/
class Getintersetlistviewloadingindicator extends StatelessWidget {
  const Getintersetlistviewloadingindicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFading(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 5),
        child: SizedBox(
          height: 300.h,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return EventsNearYouLoadingIndicator();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
