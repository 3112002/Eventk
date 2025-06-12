/*Yara❤️*/
class SignupModel {
  String status;
  String message;
  SignupModel({required this.status, required this.message});
  factory SignupModel.fromJson(json) {
    return SignupModel(status: json['status'], message: json['message']);
  }
}
