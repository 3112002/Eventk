import 'package:dartz/dartz.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Features/Booking_History/Data/models/BookingOrder_model.dart';
import 'package:eventk/Features/Booking_History/Data/models/OrderItem_model.dart';

abstract class Bookinghistoryrepo {
  Future<Either<Failures, List<BookingorderModel>>> fetchBookingHistory();
  Future<Either<Failures, List<OrderitemModel>>> getOrderItem(int orderID);
  Future<Either<Failures, String>> refundItems(
      int orderId, List<Map<String, dynamic>> items);
}
