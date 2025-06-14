import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:flutter/material.dart';

class Authprovider with ChangeNotifier {
  final CacheHelper cacheHelper;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Authprovider(this.cacheHelper) {
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final token = await cacheHelper.getDataString(key: 'token');
    _isLoggedIn = token != null && token.isNotEmpty;
    notifyListeners();
  }

  void login(String token) {
    cacheHelper.saveData(key: 'token', value: token);
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    cacheHelper.removeData(key: 'token');
    _isLoggedIn = false;
    notifyListeners();
  }
}
