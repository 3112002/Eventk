class ChangepasswordModel {
  final String status;
  final String message;
  ChangepasswordModel({required this.message, required this.status});
  factory ChangepasswordModel.fromJson(json) {
    return ChangepasswordModel(
      status: json['status'] ?? 'Failed',
      message: json['message'] ?? '',
    );
  }
}
