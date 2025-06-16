import 'package:flutter/foundation.dart';

class AddInterestmodel {
  String Status;
  String Message;
  AddInterestmodel({required this.Status, required this.Message});
  factory AddInterestmodel.fromJson(json) {
    return AddInterestmodel(Status: json['status'], Message: json['message']);
  }
}
