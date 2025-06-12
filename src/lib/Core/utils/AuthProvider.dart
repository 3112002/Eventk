import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:flutter/material.dart';

class Authprovider with ChangeNotifier {
  final CacheHelper cacheHelper;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Authprovider(this.cacheHelper) {
    _isLoggedIn = cacheHelper.getDataString(key: 'token') != null;
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
