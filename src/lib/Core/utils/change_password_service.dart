import 'package:dio/dio.dart';
import 'package:eventk/Features/Profille/Data/models/change_password.dart';
import 'package:eventk/helper/api.dart';

import 'package:shared_preferences/shared_preferences.dart';

/*Yara❤️*/
class ChangepasswordService {
  final Api api;
  final String url = "http://eventk.runasp.net/api/Profile/change-password";
  ChangepasswordService({required this.api});
  Future<ChangepasswordModel> changePass(
      String oldPass, String newPass, String confirmPass) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw 'user not authorized';
    }
    print('token is $token');

    try {
      final response = await api.post(
        url: url,
        body: {
          'oldPassword': oldPass,
          'password': newPass,
          'confirmPassword': confirmPass,
        },
        token: token,
      );

      return ChangepasswordModel.fromJson(response);
    } on DioException catch (e) {
      String errorMessage = "Wrong old password";

      if (e.response?.data is Map && e.response!.data['status'] == 'Failed') {
        errorMessage = e.response!.data['message'] ?? 'Wrong old password';
      } else if (e.response?.data is List) {
        // print("⚠️ Backend returned a list: ${e.response!.data}");
        errorMessage = 'Unexpected response format from server';
      }

      throw Exception(errorMessage);
    }
  }
}
