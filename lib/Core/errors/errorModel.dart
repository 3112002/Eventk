/*Yara❤️*/
class ErrorModel {
  String status;
  String message;

  ErrorModel({required this.status, required this.message});
  factory ErrorModel.fromJson(json) {
    return ErrorModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
