import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/helper/api.dart';

class AddinteretsService {
  final Api api;
  final String url = "http://eventk.runasp.net/api/Interest/add-interest";
  AddinteretsService({required this.api});
  Future<ErrorModel> addInterest({required int eventID}) async {
    try {
      final token = CacheHelper().getDataString(key: 'token');
      if (token == null) {
        throw CustomExceptions('user not authorized , please login again');
      }
      final response = await api.post(url: url, token: token, body: {
        "eventId": eventID,
      });
      print('add Interest Response: $response');
      return ErrorModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to toggle interest: $e");
    }
  }
}
