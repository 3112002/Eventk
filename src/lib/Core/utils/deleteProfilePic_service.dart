import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/helper/api.dart';

class DeleteprofilepicService {
  final Api api;
  final String url =
      "http://eventk.runasp.net/api/Profile/delete-profile-picture";
  DeleteprofilepicService({required this.api});
  Future<ErrorModel> deleteProfilePic() async {
    final token = CacheHelper().getDataString(key: 'token');
    if (token == null) {
      throw 'user not authorized';
    }
    print('token is $token');
    try {
      final response = await api.delete(url: url, token: token);
      return ErrorModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to delete profile picture: ${e.toString()}');
    }
  }
}
