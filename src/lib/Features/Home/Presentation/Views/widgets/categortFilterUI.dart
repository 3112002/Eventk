import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/FailureScaffold.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Home/Data/model/categoriesModel.dart';
import 'package:eventk/Features/Home/Presentation/Manager/category_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/category_state.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/*Yara Adel Mohamed*/
class CategoryFilterUI extends StatefulWidget {
  const CategoryFilterUI({super.key, this.initialValue, this.onChanged});
  final List<int>? initialValue;
  final ValueChanged<List<int>>? onChanged;
  @override
  State<CategoryFilterUI> createState() => _CategoryFilterUIState();
}

class _CategoryFilterUIState extends State<CategoryFilterUI> {
  List<int> selectedCategoryIds = [];
  List<CategoriesModel> categories = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      selectedCategoryIds = List<int>.from(widget.initialValue!);
    } else {
      final cachedIds = getIt<CacheHelper>().getData(key: "categoryIds");
      if (cachedIds != null && cachedIds is List) {
        selectedCategoryIds = List<int>.from(cachedIds);
      }
    }
    BlocProvider.of<CategoryCubit>(context).Category();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
      if (state is SuccessCategoryState) {
        categories = state.categories;
      } else if (state is LoadingCategoryState) {
        isLoading = true;
      } else if (state is FailureCategoryState) {
        setState(() => isLoading = false);
        Text('oops, there was an error , try later !');
        isLoading = false;
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: isLoading!,
        progressIndicator: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kButtonsColor),
        ),
        child: ListView.builder(
            // scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return buildCheckbox(
                  categories[index].categoryId, categories[index].categoryName);
            }),
      );
    });
  }

  Widget buildCheckbox(int value, String label) {
    bool isChecked = selectedCategoryIds.contains(value);
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          activeColor: Colors.blue,
          onChanged: (checked) {
            setState(() {
              if (checked == true) {
                selectedCategoryIds.add(value);
              } else {
                selectedCategoryIds.remove(value);
              }
              getIt<CacheHelper>().saveData(
                key: "categoryIds",
                value: selectedCategoryIds,
              );

              widget.onChanged?.call(selectedCategoryIds);
            });
          },
        ),
        Text(
          label,
          style: Styles.styleText20,
        ),
      ],
    );
  }
}
