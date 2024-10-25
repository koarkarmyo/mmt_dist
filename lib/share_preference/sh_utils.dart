


import 'package:shared_preferences/shared_preferences.dart';

class SharePrefUtils {
  late SharedPreferences _sharedPreferences;
  static final SharePrefUtils _preferences = SharePrefUtils._internal();

  SharePrefUtils._internal();

  factory SharePrefUtils() {
    return _preferences;
  }

  Future<bool> saveMessage(String message) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setString('TOKEN_KEY', message);
  }

  Future<bool> saveString(String key, String message) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setString(key, message);
  }

  Future<String?> getString(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(key);
  }

  Future<bool> _saveData(String key, String message) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setString(key, message);
  }

  Future<String?> _getDataString(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return await _sharedPreferences.getString(key);
  }

  Future<bool> saveBool(String key, bool b) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setBool(key, b);
  }

  Future<bool?> getBool(String key) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.getBool(key) == null) {
      return false;
    } else {
      return _sharedPreferences.getBool(key);
    }
  }

  clearAll() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.clear();
  }

  Future<bool> delete(String key) async{
    _sharedPreferences = await SharedPreferences.getInstance();
    return await _sharedPreferences.remove(key);
  }
}
