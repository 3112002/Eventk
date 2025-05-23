/*Yara❤️*/

class LoginModel {
  String status;
  String token;
  LoginModel({required this.status, required this.token});
  factory LoginModel.fromJson(json) {
    return LoginModel(
      status: json['status'],
      token: json['token'],
    );
  }
}
