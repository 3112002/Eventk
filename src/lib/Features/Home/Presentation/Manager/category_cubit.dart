import 'package:eventk/Features/Home/Presentation/Manager/category_state.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*Yara Adel Mohamed*/
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.homeRepo) : super(InitialCategoryState());
  HomeRepo homeRepo;
  Future<void> Category() async {
    emit(LoadingCategoryState());
    final result = await homeRepo.requestForCategories();
    result.fold((Failures) => emit(FailureCategoryState(Failures.errorMessage)),
        (CategoriesList) => emit(SuccessCategoryState(CategoriesList)));
  }
}
