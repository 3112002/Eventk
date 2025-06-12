import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Booking_History/Data/models/BookingOrder_model.dart';
import 'package:eventk/helper/api.dart';

class BookinghistoryService {
  final Api api;
  BookinghistoryService({required this.api});
  Future<List<BookingorderModel>> getBookingHistory() async {
    final token = CacheHelper().getData(key: 'token');
    final String url = "http://eventk.runasp.net/api/BookingHistory/orders";
    try {
      final response = await api.get(url: url, token: token);
      final List<dynamic> data = response;
      return data.map((json) => BookingorderModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to load booking history: $e");
    }
  }
}
