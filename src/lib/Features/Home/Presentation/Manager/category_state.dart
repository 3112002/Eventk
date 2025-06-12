import 'package:eventk/Features/Home/Data/model/categoriesModel.dart';

/*Yara Adel Mohamed*/
abstract class CategoryState {}

class InitialCategoryState extends CategoryState {}

class SuccessCategoryState extends CategoryState {
  final List<CategoriesModel> categories;
  SuccessCategoryState(this.categories);
}

class LoadingCategoryState extends CategoryState {}

class FailureCategoryState extends CategoryState {
  String errMessage;
  FailureCategoryState(this.errMessage);
}
