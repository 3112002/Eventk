import 'package:eventk/Core/widgets/customErrorWidgets.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Home/Data/model/categoriesModel.dart';
import 'package:eventk/Features/Home/Presentation/Manager/category_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/category_state.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/exploreCategories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Yara❤️*/

bool isLoading = false;
final String name = '';
List<CategoriesModel> categories = [];

/*Yara Adel*/
class Explorecategorieslistview extends StatelessWidget {
  const Explorecategorieslistview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
      if (state is SuccessCategoryState) {
        categories = state.categories;
        return SizedBox(
          height: 150.sp,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: ExploreCategories(categories: categories[index]));
              }),
        );
      } else if (state is LoadingCategoryState) {
        return CustomLoadingWidgets();
      } else if (state is FailureCategoryState) {
        return CustomErrorWidgets(errMessage: state.errMessage);
      } else {
        return CustomLoadingWidgets();
      }
    });
  }
}
