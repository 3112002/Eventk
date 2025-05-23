import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Profille/Data/models/profile_model.dart';
import 'package:eventk/helper/api.dart';

class ProfileService {
  final Api api;

  final String url = "http://eventk.runasp.net/api/Profile/me";
  ProfileService({required this.api});
  Future<ProfileModel> fetchProfile() async {
    final token = CacheHelper().getDataString(key: 'token');
    if (token == null) {
      throw 'user not authorized';
    }
    print('token is $token');
    try {
      final response = await api.get(url: url, token: token);
      print("profile response $response");
      return ProfileModel.fromJson(response);
    } on DioException catch (e) {
      String errorMessage = "error occurred";

      if (e.response?.data is Map && e.response!.data['status'] == 'Failed') {
        errorMessage = e.response!.data['message'] ?? 'error occurred';
      } else if (e.response?.data is List) {
        errorMessage = 'Unexpected response format from server';
      }
      throw Exception(errorMessage);
    }
  }
}
