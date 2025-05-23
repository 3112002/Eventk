import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eventk/Core/errors/failures.dart';
import 'package:eventk/Core/utils/BookingHistory_service.dart';
import 'package:eventk/Core/utils/BookingItem_service.dart';
import 'package:eventk/Core/utils/Refund_service.dart';
import 'package:eventk/Features/Booking_History/Data/models/BookingOrder_model.dart';
import 'package:eventk/Features/Booking_History/Data/models/OrderItem_model.dart';
import 'package:eventk/Features/Booking_History/Domain/BookingHistoryRepo.dart';
import 'package:eventk/helper/api.dart';

class Bookingorderrepoimpl implements Bookinghistoryrepo {
  @override
  Future<Either<Failures, List<BookingorderModel>>>
      fetchBookingHistory() async {
    try {
      var getBookingHistory =
          await BookinghistoryService(api: Api(dio: Dio())).getBookingHistory();
      return right(getBookingHistory);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<OrderitemModel>>> getOrderItem(
      int orderId) async {
    try {
      final res = await BookingitemService(api: Api(dio: Dio()))
          .fetchOrderItems(orderId);
      return right(res);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> refundItems(
      int orderId, List<Map<String, dynamic>> items) async {
    try {
      final res = await RefundService(api: Api(dio: Dio()))
          .requesrRefund(orderId, items);
      return right(res);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
