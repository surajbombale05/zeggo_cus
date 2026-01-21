import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeggo_cus/constants/app_url.dart';

class LocalStorageUtils {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance ??= await SharedPreferences.getInstance();
  }

  static String? getUserId() {
    return _instance?.getString(AppString.sharedPrefUserIdKey);
  }

  static Future<void> saveUserId(String id) async {
    await _instance?.setString(AppString.sharedPrefUserIdKey, id);
    log('User id saved to localstorage $id');
  }

  static Future<void> clear() async {
    await _instance?.clear();
  }
}
