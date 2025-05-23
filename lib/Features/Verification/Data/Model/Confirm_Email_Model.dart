/*Yara Adel💕*/
class ConfirmEmailModel {
  String status;
  String message;
  ConfirmEmailModel({required this.status, required this.message});
  factory ConfirmEmailModel.fromJson(json) {
    return ConfirmEmailModel(status: json['status'], message: json['message']);
  }
}
