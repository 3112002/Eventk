import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Home/Data/model/categoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel Mohamed*/
class ExploreCategories extends StatelessWidget {
  ExploreCategories({super.key, required this.categories, this.name});
  CategoriesModel categories;
  var name;
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
