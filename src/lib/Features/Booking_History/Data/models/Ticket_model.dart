class TicketModel {
  final String code;
  final String status;
  TicketModel({required this.code, required this.status});
  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      code: json['code'],
      status: json['status'],
    );
  }
}
