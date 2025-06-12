import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Organization/Data/models/OrganizationToFollowModel.dart';
import 'package:eventk/helper/api.dart';

class OrganizationtofollowService {
  final Api api;
  OrganizationtofollowService({required this.api});
  Future<List<Organizationtofollowmodel>> getOrganizations(
      bool isFollowing) async {
    final token = CacheHelper().getData(key: 'token');
    try {
      final String url =
          'http://eventk.runasp.net/api/Organization/get-organizations?IsFollowing=$isFollowing';
      final response = await api.get(
        url: url,
        token: token,
      );

      List<dynamic> jsonList = response;

      return jsonList
          .map((json) => Organizationtofollowmodel.fromJson(json))
          .toList();
    } catch (e) {
      print('Failed to load organizations: $e');
      throw Exception('Failed to load organizations: $e');
    }
  }
}
