import 'package:eventk/Core/widgets/FailureScaffold.dart';
import 'package:eventk/Features/Home/Data/model/categoriesModel.dart';
import 'package:eventk/Features/Home/Presentation/Manager/category_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/category_state.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/exploreCategories.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
/*Yara❤️*/

bool isLoading = false;
final String name = '';
List<CategoriesModel> categories = [];

/*Yara Adel*/
class Explorecategorieslistview extends StatelessWidget {
  const Explorecategorieslistview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
      if (state is SuccessCategoryState) {
        categories = state.categories;
      } else if (state is LoadingCategoryState) {
        isLoading = true;
      } else if (state is FailureCategoryState) {
        showFailureSnackBar(context, state.errMessage);
        isLoading = false;
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
          inAsyncCall: isLoading!,
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kButtonsColor),
          ),
          child: SizedBox(
            height: 150.sp,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: ExploreCategories(categories: categories[index]));
                }),
          ));
    });
  }
}
