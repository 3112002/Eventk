import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/interset_model/interset_model.dart';
import 'package:eventk/Features/Intersted/Data/models/getInterest_model.dart';
import 'package:eventk/helper/api.dart';

class GetInterestService {
  final Api api;
  final String url = "http://eventk.runasp.net/api/Interest/get-interest";
  GetInterestService({required this.api});
  Future<List<EventsModel>> getInterest() async {
    try {
      final token = CacheHelper().getDataString(key: 'token');
      if (token == null) {
        throw CustomExceptions('user not authorized , please login again');
      }
      final response = await api.get(url: url, token: token);
      print('Get interests response: $response');
      if (response == null || response is! List) {
        throw CustomExceptions('Invalid response format');
      }
      final events = (response as List).map((event) {
        return EventsModel.fromJson(event);
      }).toList();
      return events;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomExceptions('Session expired. Please login again.');
      }
      throw CustomExceptions('Network error: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw CustomExceptions('An unexpected error occurred');
    }
  }
}
