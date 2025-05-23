class Phonenovalidation {
  static bool isvalidNumber(String input) {
    final regex = RegExp(r'^1[0-9]{9}$');
    return regex.hasMatch(input);
  }
}
