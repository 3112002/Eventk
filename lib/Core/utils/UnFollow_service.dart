import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/helper/api.dart';

class UnfollowService {
  final Api api;
  final String url =
      'http://eventk.runasp.net/api/Organization/unfollow-organization';
  UnfollowService({required this.api});
  Future<ErrorModel> unfollowOrganization({required int organizationId}) async {
    try {
      final token = CacheHelper().getDataString(key: 'token');
      if (token == null) {
        throw CustomExceptions('User not authorized');
      }
      final response = await api.delete(
        url: '$url?organizationId=$organizationId',
        token: token,
        body: {'organizationId': organizationId},
      );
      return ErrorModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to UnFollow: $e");
    }
  }
}
