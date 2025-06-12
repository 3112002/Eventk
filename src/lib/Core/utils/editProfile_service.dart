import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Profille/Data/models/editProfile_model.dart';
import 'package:eventk/helper/api.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class EditprofileService {
  final Api api;
  final String url = "http://eventk.runasp.net/api/Profile/edit-profile";
  EditprofileService({required this.api});
  Future<EditprofileModel> editProfile({
    required String firstName,
    required String lastName,
    required String userName,
    String? bio,
    required String birthDate,
    String? profilePicPath,
  }) async {
    try {
      final token = CacheHelper().getDataString(key: 'token');
      if (token == null) {
        throw 'user not authorized';
      }
      print('token is $token');

      final formData = FormData.fromMap({
        'FirstName': firstName,
        'LastName': lastName,
        'UserName': userName,
        'Bio': bio ?? "",
        'BirthDate': birthDate,
        if (profilePicPath != null && profilePicPath.isNotEmpty)
          'ProfilePicture': await MultipartFile.fromFile(
            profilePicPath,
            filename: basename(profilePicPath),
            contentType: MediaType.parse(
              lookupMimeType(profilePicPath) ?? 'application/octet-stream',
            ),
          ),
      });

      final response = await api.put(
        url: url,
        body: formData,
        token: token,
        isFormData: true,
      );
      print(response);
      if (response is Map<String, dynamic>) {
        return EditprofileModel.fromJson(response);
      } else {
        throw Exception('Unexpected response format from server');
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
