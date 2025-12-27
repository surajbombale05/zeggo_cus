import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static String? _userId;
  static String? _token;

  static Future<void> writeSecureStorage(String key, String value) async {
    log("Storage write: $key = $value");

    if (key == userIdKey) _userId = value;
    if (key == userTokenKey) _token = value;

    await storage.write(key: key, value: value);
  }

  static Future<String> getUserid() async {
    if (_userId != null) return _userId!;
    _userId = await storage.read(key: userIdKey);
    return _userId ?? "";
  }

  static Future<String> getUserToken() async {
    if (_token != null) return _token!;
    _token = await storage.read(key: userTokenKey);
    return _token ?? "";
  }

  static void setSession({required String userId, required String token}) {
    _userId = userId;
    _token = token;
  }

  static void clearSession() {
    _userId = null;
    _token = null;
    storage.deleteAll();
  }

  static Future clear() async {
    await storage.deleteAll();
    log('All secure data cleared.');
  }

  static Future<List<String>> getRecentSearches() async {
    String? data = await storage.read(key: recentSearchKey);

    if (data == null || data.isEmpty) return [];

    return data.split("||");
  }

  static Future saveRecentSearch(String query) async {
    List<String> searches = await getRecentSearches();

    searches.remove(query);

    searches.insert(0, query);

    if (searches.length > 5) {
      searches = searches.sublist(0, 5);
    }

    await storage.write(key: recentSearchKey, value: searches.join("||"));
  }

  static Future<List<String>> removeRecentSearch(int index) async {
    String? data = await storage.read(key: recentSearchKey);

    if (data == null || data.isEmpty) return [];

    List<String> list = data.split("||");

    if (index >= 0 && index < list.length) {
      list.removeAt(index);
    }

    await storage.write(key: recentSearchKey, value: list.join("||"));

    return list;
  }

  static Future clearRecentSearches() async {
    await storage.delete(key: recentSearchKey);
  }

  static const String recentSearchKey = "RecentSearches";
  static String userIdKey = "UserID";
  static String userTokenKey = "UserTokenKey";
}
