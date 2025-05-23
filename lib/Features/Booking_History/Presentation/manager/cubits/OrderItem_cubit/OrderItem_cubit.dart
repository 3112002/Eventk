import 'package:eventk/Features/Booking_History/Domain/BookingHistoryRepo.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/OrderItem_cubit/OrderItem_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderitemCubit extends Cubit<OrderitemStates> {
  final Bookinghistoryrepo repo;
  OrderitemCubit(this.repo) : super(OrderItemInitialState());
  Future<void> fetchOrderItems(int orderId) async {
    emit(OrderItemLoadingState());
    try {
      final res = await repo.getOrderItem(orderId);
      res.fold(
        (failure) {
          emit(OrderItemFailureState(failure.errorMessage));
        },
        (orders) {
          emit(OrderItemSuccessState(orders));
        },
      );
    } catch (e) {
      emit(OrderItemFailureState(e.toString()));
    }
  }
}
