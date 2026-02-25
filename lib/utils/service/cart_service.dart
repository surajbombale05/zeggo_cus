import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';

class CartService {
  static const String _cartKey = "cart_items";

  static Future<Map<String, CartItem>> _getCartMap() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cartKey);
    if (data == null) return {};

    final decoded = jsonDecode(data) as Map<String, dynamic>;
    return decoded.map(
      (key, value) => MapEntry(key, CartItem.fromJson(value)),
    );
  }

  static Future<void> saveItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final map = {
      for (var item in items) item.productId: item.toJson(),
    };
    await prefs.setString(_cartKey, jsonEncode(map));
  }

  static Future<List<CartItem>> getItems() async {
    final cart = await _getCartMap();
    return cart.values.toList();
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
