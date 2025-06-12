import 'package:dio/dio.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/helper/api.dart';

class PaymentintentService {
  final Api api;
  PaymentintentService({required this.api});
  Future<String> createPaymentIntent({
    required List<Map<String, dynamic>> items,
    required String phoneNumber,
  }) async {
    final token = CacheHelper().getData(key: 'token');
    final url = "http://eventk.runasp.net/api/Payment/payment/intention";

    try {
      final response = await api.post(url: url, token: token, body: {
        'items': items,
        'phoneNumber': phoneNumber,
      });
      return response;
    } on DioException catch (e) {
      throw CustomExceptions('Payment error: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw CustomExceptions('Unexpected error: $e');
    }
  }
}
