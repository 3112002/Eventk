import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Features/Payment/Data/models/TicketTypeModel.dart';
import 'package:eventk/helper/api.dart';

class TickettypesService {
  final Api api;
  TickettypesService({required this.api});
  Future<List<Tickettypemodel>> fetchTicketTypes(int eventId) async {
    final token = CacheHelper().getData(key: 'token');
    try {
      final String url =
          "http://eventk.runasp.net/api/Events/get-event/$eventId/ticket-types";
      final response = await api.get(
        url: url,
        token: token,
      );
      print('ticket info : $response');
      return (response as List)
          .map((json) => Tickettypemodel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomExceptions('Session expired.Please login again');
      }
      throw CustomExceptions('Network error: ${e.message}');
    } catch (e) {
      print("Error Fetching ticket types:$e");
      throw CustomExceptions('An unexpected error occurres: $e');
    }
  }
}
