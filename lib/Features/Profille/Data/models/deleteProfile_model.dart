class DeleteprofileModel {
  final String status;
  final String message;
  DeleteprofileModel({required this.message, required this.status});
  factory DeleteprofileModel.fromJson(json) {
    return DeleteprofileModel(
      status: json['status'] ?? 'Failed',
      message: json['message'] ?? '',
    );
  }
}
