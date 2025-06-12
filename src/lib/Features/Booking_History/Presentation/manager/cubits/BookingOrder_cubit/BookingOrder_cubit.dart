import 'package:eventk/Features/Booking_History/Domain/BookingHistoryRepo.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/BookingOrder_cubit/BookingOrder_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingorderCubit extends Cubit<BookingorderStates> {
  final Bookinghistoryrepo bookingRepo;
  BookingorderCubit({required this.bookingRepo}) : super(BookingInitialState());
  Future<void> fetchBookingHistory() async {
    emit(BookingLoadingState());
    try {
      final res = await bookingRepo.fetchBookingHistory();
      res.fold(
        (failure) => emit(BookingFailureState(failure.errorMessage)),
        (orders) => emit(BookingSuccessState(orders)),
      );
    } catch (e) {
      emit(BookingFailureState(e.toString()));
    }
  }
}
