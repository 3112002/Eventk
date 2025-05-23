import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/helper/api.dart';

class RefundService {
  final Api api;
  RefundService({required this.api});
  Future<String> requesrRefund(
      int orderId, List<Map<String, dynamic>> items) async {
    final token = CacheHelper().getData(key: 'token');
    final String url = "http://eventk.runasp.net/api/Payment/payment/refund";

    try {
      final response = await api.post(
        url: url,
        token: token,
        body: {
          'orderId': orderId,
          'items': items,
        },
      );
      return response.toString();
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        final message =
            e.response?.data['message'] ?? 'Refund period has expired.';
        return message;
      }
      throw Exception("Failed to request refund: ${e.message}");
    } catch (e) {
      throw Exception("Failed to load booking history: $e");
    }
  }
}
