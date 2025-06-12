import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/helper/api.dart';

class DeleteinterestService {
  final Api api;
  final String url = "http://eventk.runasp.net/api/Interest/delete-interest";
  DeleteinterestService({required this.api});
  Future<ErrorModel> deleteInterest({required int eventId}) async {
    try {
      final token = CacheHelper().getDataString(key: 'token');
      if (token == null) {
        throw CustomExceptions('user not authorized , please login again');
      }
      final response = await api.delete(url: url, token: token, body: {
        'eventId': eventId,
      });
      print('Delete Interest Response:$response');
      return ErrorModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to delete interest: $e");
    }
  }
}
