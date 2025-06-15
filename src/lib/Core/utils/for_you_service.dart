import 'package:dio/dio.dart';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Features/Foryou/Data/Model/for_you_model/for_you_model.dart';

class ForYouService {
  final Dio dio;
  ForYouService(this.dio);
  Future<ForYouModel> getForYouEventsService() async {
    try {
      var token = getIt<CacheHelper>().getData(key: 'token');
      Map<String, String> headers = {
        'accept': '*/*',
      };
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
      Response response = await dio.get(
        'http://eventk.runasp.net/api/ForYou',
        options: Options(
          headers: headers,
          validateStatus: (status) =>
              status! >= 200 && status < 300 || status == 404,
        ),
      );
      ForYouModel getForYouEvents = ForYouModel.fromJson(response.data);
      return getForYouEvents;
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
