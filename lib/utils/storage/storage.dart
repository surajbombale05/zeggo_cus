import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeggo_cus/constants/app_url.dart';

class LocalStorageUtils {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future<String?> getUserId() async {
    _instance ??= await SharedPreferences.getInstance();
    return _instance?.getString(AppString.sharedPrefUserIdKey);
  }

  static Future<void> saveUserId(String id) async {
    _instance ??= await SharedPreferences.getInstance();
    await _instance?.setString(AppString.sharedPrefUserIdKey, id);
    log('User id saved to localstorage $id');
  }

  static Future<String?> getToken() async {
    _instance ??= await SharedPreferences.getInstance();
    return _instance?.getString(AppString.sharedPrefTokenKey);
  }

  static Future<void> saveToken(String id) async {
    _instance ??= await SharedPreferences.getInstance();
    await _instance?.setString(AppString.sharedPrefTokenKey, id);
    log('sharedPrefTokenKey saved to localstorage $id');
  }

  static Future<void> clear() async {
    _instance ??= await SharedPreferences.getInstance();
    await _instance?.clear();
  }
}
