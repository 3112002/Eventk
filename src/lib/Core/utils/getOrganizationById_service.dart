import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Organization/Data/models/getOrganizationId_model.dart';
import 'package:eventk/helper/api.dart';

class GetorganizationbyidService {
  final Api api;

  GetorganizationbyidService({required this.api});
  Future<GetorganizationByIdModel> fetchOrganizationById({
    required int organizationId,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    final token = CacheHelper().getDataString(key: 'token');
    
    final String url =
        "http://eventk.runasp.net/api/Organization/get-organization/$organizationId";
    try {
      final response = await api.get(
        url: url,
        token: token??" ",
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );
      final model = GetorganizationByIdModel.fromJson(response);

      return model;
    } on DioException catch (e) {
      String errorMessage = "Error occurred";
      if (e.response?.data is Map && e.response!.data['status'] == 'Failed') {
        errorMessage = e.response!.data['message'] ?? 'Error occurred';
      } else if (e.response?.data is List) {
        errorMessage = 'Unexpected response format from server';
      }

      throw Exception(errorMessage);
    }
  }
}
