class EditprofileModel {
  final String status;
  final String message;
  EditprofileModel({required this.status, required this.message});
  factory EditprofileModel.fromJson(Map<String, dynamic> json) {
    return EditprofileModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
