class Tickettypemodel {
  final int ticketTypeId;
  final String ticketName;
  final double price;
  final int availableTickets;
  Tickettypemodel(
      {required this.ticketTypeId,
      required this.ticketName,
      required this.price,
      required this.availableTickets});
  factory Tickettypemodel.fromJson(Map<String, dynamic> json) {
    return Tickettypemodel(
        ticketTypeId: json['ticketTypeId'],
        ticketName: json['ticketName'],
        price: (json['price'] as num).toDouble(),
        availableTickets: json['availableTickets']);
  }
}
