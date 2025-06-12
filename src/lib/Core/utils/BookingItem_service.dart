import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Booking_History/Data/models/OrderItem_model.dart';
import 'package:eventk/helper/api.dart';

class BookingitemService {
  final Api api;
  BookingitemService({required this.api});
  Future<List<OrderitemModel>> fetchOrderItems(int orderId) async {
    final token = CacheHelper().getData(key: 'token');
    final String url =
        "http://eventk.runasp.net/api/BookingHistory/order/$orderId";
    try {
      final response = await api.get(
        url: url,
        token: token,
      );
      return (response as List)
          .map((json) => OrderitemModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("Failed to load booking history: $e");
    }
  }
}
