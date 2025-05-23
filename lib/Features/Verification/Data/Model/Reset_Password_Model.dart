/*Yara Adel💕*/
class ResetPasswordModel {
  String status;
  String message;
  ResetPasswordModel({required this.status, required this.message});
  factory ResetPasswordModel.fromjson(json) {
    return ResetPasswordModel(status: json['status'], message: json['message']);
  }
}
