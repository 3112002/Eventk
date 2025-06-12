import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/End_Point.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/get_events_model.dart';

/*Yara Adel Mohamed */
class GetEventsService {
  final Dio dio;
  GetEventsService(this.dio);
  Future<GetEventsModel> GetEvents(String endPoint, int pageNumber) async {
    try {
      Response response = await dio.get(
        EndPoint.baseUrlEvents + EndPoint.getEvents + endPoint,
        options: Options(
          headers: {
            'accept': '*/*',
          },
          validateStatus: (status) =>
              status! >= 200 && status < 300 || status == 404,
        ),
      );
      // Map<String, dynamic> jsonData = response.data;
      // List<GetEventsModel> getEventsList = [];
      // List<Item> items=[];

      GetEventsModel getEventsModel = GetEventsModel.fromJson(response.data);
      // getEventsList.add(getEventsModel);

      return getEventsModel;
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
