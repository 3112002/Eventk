/*Yara Adel💕*/

class ForgetPasswordModel {
  String status;
  String message;
  ForgetPasswordModel({required this.status, required this.message});
  factory ForgetPasswordModel.fromJson(json) {
    return ForgetPasswordModel(
        status: json['status'], message: json['message']);
  }
}
