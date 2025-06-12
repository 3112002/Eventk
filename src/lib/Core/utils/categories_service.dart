import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Features/Home/Data/model/categoriesModel.dart';

/*Yara❤️*/
class CategoriesService {
  final Dio dio;
  CategoriesService(this.dio);
  Future<List<CategoriesModel>> requestForCategories() async {
    try {
      Response response = await dio.get(
        'http://eventk.runasp.net/api/Category/categories',
        options: Options(
          headers: {
            'accept': '*/*',
          },
          validateStatus: (status) => status! >= 200 && status < 300,
        ),
      );
      List<dynamic> jsonData = response.data;
      List<CategoriesModel> categoryList = [];

      for (var item in jsonData) {
        CategoriesModel categoriesModel = CategoriesModel.fromJson(item);
        categoryList.add(categoriesModel);
      }
      return categoryList;
    } on DioException catch (e) {
      ErrorModel errorModel = ErrorModel.fromJson(e.response!.data);
      final String errorMessage =
          errorModel.message ?? 'oops ,there was an error , try later !';
      throw CustomExceptions(errorMessage);
    } catch (e) {
      throw CustomExceptions((e.toString()));
    }
  }
}
