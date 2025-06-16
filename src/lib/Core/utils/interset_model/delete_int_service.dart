import 'package:dio/dio.dart';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Features/Intersted/Data/Models/addInterestMode.dart';

class DeleteIntService {
  final Dio dio;
  DeleteIntService(this.dio);
  Future<AddInterestmodel?> DeleteInt({required int eventId}) async {
    try {
      var token = getIt<CacheHelper>().getData(key: 'token');
      Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json'
      };
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
      Response response = await dio.delete(
        'http://eventk.runasp.net/api/Interest/delete-interest',
        data: {
          'eventId': eventId,
        },
        options: Options(
          headers: headers,
          validateStatus: (status) => status! < 500,
        ),
      );
      AddInterestmodel addInterestmodel = AddInterestmodel.fromJson(response);
      return addInterestmodel;
      //print();
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
