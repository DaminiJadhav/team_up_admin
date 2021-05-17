import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String isLogin = "isLogin";
  static String adminId = "adminId";
  static String username = "username";
  static String email = "email";
  static String name = "name";
  static String fcm = "FCM";

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Future<bool> setIsLogin(bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(isLogin, value) ?? Future.value(false);
  }

  static getIsLogin() {
    return _prefsInstance.getBool(isLogin) ?? false;
  }

  static Future<int> setAdminId(int id) async {
    var _prefs = await _instance;
    return _prefs?.setInt(adminId, id) ?? Future.value(0);
  }

  static getAdminId() {
    return _prefsInstance.getInt(adminId);
  }

  static Future<String> setName(String uName) async {
    var _prefs = await _instance;
    return _prefs?.setString(name, uName) ?? Future.value('');
  }

  static getName() {
    return _prefsInstance.getString(name);
  }

  static Future<String> setUserName(String uName) async {
    var _prefs = await _instance;
    return _prefs?.setString(username, uName) ?? Future.value('');
  }

  static getUserName() {
    return _prefsInstance.getString(username);
  }

  static Future<String> setEmail(String uEmail) async {
    var _prefs = await _instance;
    return _prefs?.setString(email, uEmail) ?? Future.value('');
  }

  static getEmail() {
    return _prefsInstance.getString(email);
  }

  static Future<String> setFcm(String Fcm) async {
    var _prefs = await _instance;
    return _prefs?.setString(fcm, Fcm) ?? Future.value('');
  }

  static getFcm() {
    return _prefsInstance.getString(fcm);
  }
}
