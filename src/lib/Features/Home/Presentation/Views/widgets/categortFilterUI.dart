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

int selectedValue = 0;

/*Yara Adel Mohamed*/
class CategoryFilterUI extends StatefulWidget {
  const CategoryFilterUI({super.key, this.initialValue, this.onChanged});
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  @override
  State<CategoryFilterUI> createState() => _CategoryFilterUIState();
}

class _CategoryFilterUIState extends State<CategoryFilterUI> {
  late String? groupValue;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      groupValue = widget.initialValue;
    }
    BlocProvider.of<CategoryCubit>(context).Category();
  }

  List<CategoriesModel> categories = [];

  void onChanged(String? newValue) {
    if (newValue == null) return;
    setState(() {
      groupValue = newValue;
      // getIt<CacheHelper>().saveData(key: 'selectedDate', value: groupValue);
    });
    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
      if (state is SuccessCategoryState) {
        categories = state.categories;
      } else if (state is LoadingCategoryState) {
        isLoading = true;
      } else if (state is FailureCategoryState) {
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
              return buildRadio(
                  categories[index].categoryId, categories[index].categoryName);
            }),
      );
    });
  }

  Widget buildRadio(int value, String label) {
    return Row(
      children: [
        Radio(
          groupValue: selectedValue,
          value: value,
          activeColor: Colors.blue,
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue!;
              getIt<CacheHelper>().saveData(key: "categoryId", value: value);
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
