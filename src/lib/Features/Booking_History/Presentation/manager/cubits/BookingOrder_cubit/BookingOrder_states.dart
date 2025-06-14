import 'package:eventk/Features/Booking_History/Data/models/BookingOrder_model.dart';

class BookingorderStates {}

class BookingInitialState extends BookingorderStates {}

class BookingLoadingState extends BookingorderStates {}

class BookingSuccessState extends BookingorderStates {
  final List<BookingorderModel> orders;
  BookingSuccessState(this.orders);
}

class BookingFailureState extends BookingorderStates {
  final String error;
  BookingFailureState(this.error);
}
