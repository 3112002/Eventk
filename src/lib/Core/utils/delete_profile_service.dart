import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Features/Profille/Data/models/deleteProfile_model.dart';
import 'package:eventk/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteProfileService {
  final Api api;
  final String url = 'http://eventk.runasp.net/api/Profile/delete-profile';

  DeleteProfileService({required this.api});

  Future<DeleteprofileModel> deleteProfile(String oldPassword) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw CustomExceptions('User not authorized. Please login again.');
      }
      print('sending password:$oldPassword');

      final response = await api.delete(
        url: url,
        body: {'oldPassword': oldPassword},
        token: token,
      );

      if (response == null) {
        throw CustomExceptions('Empty response from server');
      }

      if (response is! Map<String, dynamic>) {
        throw CustomExceptions('Invalid response format');
      }

      if (response['status'] == 'Success') {
        return DeleteprofileModel.fromJson(response);
      } else {
        throw CustomExceptions(
          response['message'] ?? 'Failed to delete profile',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomExceptions('Session expired. Please login again.');
      } else if (e.response?.data != null && e.response!.data is Map) {
        throw CustomExceptions(
          e.response!.data['message'] ?? 'Wrong old password',
        );
      }
      throw CustomExceptions('Network error: ${e.message}');
    } catch (e) {
      throw CustomExceptions('An unexpected error occurred');
    }
  }
}
