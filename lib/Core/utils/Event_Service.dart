import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Features/Event/Data/model/Event_model.dart';
import 'package:eventk/helper/api.dart';

class EventService {
  final Api api;
  EventService({required this.api});
  Future<EventDetailsModel> getEventDetails(int eventId)async{
    final token =CacheHelper().getData(key: 'token');
    /*
    if(token==null){
      throw CustomExceptions('User not authorized,Please login again');
    }
    */
    try{
      final String url="http://eventk.runasp.net/api/Events/get-event/$eventId";
      final response=await api.get(
        url: url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        ),
        token: token
        );
        print("response oe event is : $response");

        return EventDetailsModel.fromJson(response);
    }on DioException catch(e){
      if(e.response?.statusCode==401)
      {
        throw CustomExceptions('Session expired.Please login again');
      }
      throw CustomExceptions('Network error: ${e.message}');
    }catch(e){
      throw CustomExceptions('An unexpected error occurres: $e');
    }
  }
}

