import 'package:eventk/Features/Booking_History/Data/models/OrderItem_model.dart';

class OrderitemStates {}

class OrderItemInitialState extends OrderitemStates {}

class OrderItemLoadingState extends OrderitemStates {}

class OrderItemSuccessState extends OrderitemStates {
  final List<OrderitemModel> orders;
  OrderItemSuccessState(this.orders);
}

class OrderItemFailureState extends OrderitemStates {
  final String error;
  OrderItemFailureState(this.error);
}
