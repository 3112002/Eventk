class RefundStates {}

class RefundInitialState extends RefundStates {}

class RefundLoadingState extends RefundStates {}

class RefundSuccessState extends RefundStates {
  final String message;
  final int orderId;
  RefundSuccessState(this.message, this.orderId);
}

class RefundFailureState extends RefundStates {
  final String error;
  RefundFailureState(this.error);
}
