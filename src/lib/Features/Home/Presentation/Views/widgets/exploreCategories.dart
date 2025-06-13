import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Home/Data/model/categoriesModel.dart';
import 'package:eventk/Features/Home/Presentation/Views/allEventsPage.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/showMoreEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel Mohamed*/
class ExploreCategories extends StatelessWidget {
  const ExploreCategories({
    super.key,
    required this.categories,
  });
  final CategoriesModel categories;
//  final  String name;

  @override
  Widget build(BuildContext context) {
    final String endPoint = 'CategoriesIds=${categories.categoryId}';
    return GestureDetector(
        child: Column(
          children: [
            Container(
              height: 100.sp,
              width: 100.sp,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(categories.categoryImage!),
                ),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.h)),
            Text(
              categories.categoryName,
              style: Styles.styleText15,
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AllEventsPage(endPoint: endPoint)));
        });
  }
}
