import 'package:eventk/Features/Booking_History/Data/models/Ticket_model.dart';

class OrderitemModel {
  final String ticketTypeName;
  final String ticketTypeDetails;
  final int quantity;
  final double unitPrice;
  final bool isRefunded;
  final int orderItemId;
  final List<TicketModel> tickets;
  OrderitemModel(
      {
      required this.orderItemId,
      required this.ticketTypeName,
      required this.ticketTypeDetails,
      required this.quantity,
      required this.unitPrice,
      required this.isRefunded,
      required this.tickets});
  factory OrderitemModel.fromJson(Map<String, dynamic> json) {
    return OrderitemModel(
      ticketTypeName: json['ticketTypeName'],
      ticketTypeDetails: json['ticketTypeDetails'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      isRefunded: json['isRefunded'],
      orderItemId: json['orderItemId'],
      tickets: (json['tickets'] as List)
          .map((e) => TicketModel.fromJson(e))
          .toList(),
    );
  }
}
