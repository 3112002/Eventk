import 'package:dio/dio.dart';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/End_Point.dart';
import 'package:eventk/Core/utils/interset_model/interset_model.dart';

class Getinterset {
  final Dio dio;
  Getinterset(this.dio);
  Future<List<IntersetModel>> GetIntersets() async {
    try {
      var token = getIt<CacheHelper>().getData(key: 'token');
      Map<String, String> headers = {
        'accept': '*/*',
      };
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
      Response response = await dio.get(
        'http://eventk.runasp.net/api/Interest/get-interest',
        options: Options(
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => status! >= 200 && status < 300,
        ),
      );
      List<IntersetModel> getList = (response.data as List)
          .map((item) => IntersetModel.fromMap(item))
          .toList();
      return getList;
    } on DioException catch (e) {
      ErrorModel errorModel = ErrorModel.fromJson(e.response!.data);
      final String errorMessage =
          errorModel.message ?? 'oops, there was an error , try later !';
      throw CustomExceptions(errorMessage);
    } catch (e) {
      throw CustomExceptions((e.toString()));
    }
  }
}
