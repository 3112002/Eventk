class BookingorderModel {
  final int orderId;
  final String paidAt;
  final double totalAmount;
  final int eventId;
  final String eventName;
  final String eventPic;
  BookingorderModel({
    required this.orderId,
    required this.paidAt,
    required this.totalAmount,
    required this.eventId,
    required this.eventName,
    required this.eventPic,
  });
  factory BookingorderModel.fromJson(Map<String, dynamic> json) {
    return BookingorderModel(
        orderId: json['orderId'],
        paidAt: json['paidAt'],
        totalAmount: (json['totalAmount'] as num).toDouble(),
        eventId: json['eventId'],
        eventName: json['eventName'],
        eventPic: json['eventPicture']);
  }
}
