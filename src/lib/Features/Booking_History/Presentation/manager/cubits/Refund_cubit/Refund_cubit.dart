import 'package:eventk/Features/Booking_History/Domain/BookingHistoryRepo.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/Refund_cubit/Refund_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefundCubit extends Cubit<RefundStates> {
  final Bookinghistoryrepo repo;
  RefundCubit(this.repo) : super(RefundInitialState());
  Future<void> requesrRefund(
      int orderId, List<Map<String, dynamic>> items) async {
    emit(RefundLoadingState());
    try {
      final res = await repo.refundItems(orderId, items);
      res.fold(
        (failure) {
          emit(RefundFailureState(failure.errorMessage));
        },
        (successMessage) {
          emit(RefundSuccessState(successMessage, orderId));
        },
      );
    } catch (e) {
      emit(RefundFailureState(e.toString()));
    }
  }
}
