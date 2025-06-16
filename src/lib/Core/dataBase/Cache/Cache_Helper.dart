import 'package:shared_preferences/shared_preferences.dart';

/*Yara Adel Mohamed El-Sayed*/
class CacheHelper {
  static late SharedPreferences prefs;
  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return prefs.getString(key);
  }

  Future<bool?> getDataBool({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else if (value is bool) {
      return await prefs.setBool(key, value);
    } else if (value is List<int>) {
      List<String> stringList = value.map((e) => e.toString()).toList();
      return await prefs.setStringList(key, stringList);
    } else {
      return await prefs.setStringList(key, value);
    }
  }

  dynamic getData({required String key}) {
    var value = prefs.get(key);

    if (value is List<String>) {
      try {
        return value.map((e) => int.parse(e)).toList();
      } catch (e) {
        return value;
      }
    }

    return value;
  }

  Future<bool> removeData({required String key}) async {
    return await prefs.remove(key);
  }
}
