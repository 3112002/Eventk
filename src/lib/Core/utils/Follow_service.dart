import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/helper/api.dart';

class Followservice {
  final Api api;
  final String url =
      'http://eventk.runasp.net/api/Organization/follow-organization';
  Followservice({required this.api});
  Future<ErrorModel> followOrganization({required int organizationId}) async {
    try {
      final token = CacheHelper().getDataString(key: 'token');
      if (token == null) {
        throw CustomExceptions('User not authorized');
      }
      print('Sending POST request to $url');
      print('Request body: {organizationId: $organizationId}');
    


      final response = await api.post(
        url: '$url?organizationId=$organizationId', 
        token: token, body: {
        'organizationId': organizationId,
      });
      print('Response Body: $response');
      
      if (response['statusCode'] == 200) {
        print("Request Successful");
      } else {
        print("Error: ${response['statusCode']}");
      }
   
    

      return ErrorModel.fromJson(response);
    } catch (e) {
      print('Error: $e');
      throw Exception("Failed to Follow: $e");
    }
  }
}
