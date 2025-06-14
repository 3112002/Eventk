import 'package:eventk/Core/widgets/custom_fading.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/explorecategoriesDetaliesLoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExplorecategorieslistviewLoadingIndicator extends StatefulWidget {
  const ExplorecategorieslistviewLoadingIndicator({super.key});

  @override
  State<ExplorecategorieslistviewLoadingIndicator> createState() =>
      _ExplorecategorieslistviewLoadingIndicatorState();
}

class _ExplorecategorieslistviewLoadingIndicatorState
    extends State<ExplorecategorieslistviewLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return CustomFading(
      child: SizedBox(
        height: 150.sp,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(left: 30.w),
                        child: ExplorecategoriesDetaliesLoadingIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
