/*Yara Adel💕*/
class VerifyEmailModel {
  String status;
  String message;
  VerifyEmailModel({required this.status, required this.message});
  factory VerifyEmailModel.fromJson(json) {
    return VerifyEmailModel(status: json['status'], message: json['message']);
  }
}
