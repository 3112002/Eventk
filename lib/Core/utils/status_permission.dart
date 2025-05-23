/*Yara❤️*/
class StatusPermission {
  final String message;
  StatusPermission({required this.message});
  factory StatusPermission.fromJson(json) {
    return StatusPermission(message: json);
  }
}
