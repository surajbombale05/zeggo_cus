import 'package:flutter/material.dart';
import 'package:zeggo_cus/utils/service/cart_service.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int getQuantity(String productId) {
    return _items.firstWhere((e) => e.productId == productId, orElse: CartItem.empty).quantity;
  }

  Future<void> load() async {
    _items = await CartService.getItems();
    notifyListeners();
  }

  Future<void> add(CartItem item) async {
    final index = _items.indexWhere((e) => e.productId == item.productId);

    if (index == -1) {
      _items.add(item);
    } else {
      _items[index].quantity++;
    }

    await CartService.saveItems(_items);
    notifyListeners();
  }

  Future<void> increment(String id) async {
    final i = _items.indexWhere((e) => e.productId == id);
    if (i == -1) return;

    _items[i].quantity++;
    await CartService.saveItems(_items);
    notifyListeners();
  }

  Future<void> decrement(String id) async {
    final i = _items.indexWhere((e) => e.productId == id);
    if (i == -1) return;

    if (_items[i].quantity <= 1) {
      _items.removeAt(i);
    } else {
      _items[i].quantity--;
    }

    await CartService.saveItems(_items);
    notifyListeners();
  }

  Future<void> removeMany(List<String> productIds) async {
    _items.removeWhere((e) => productIds.contains(e.productId));
    await CartService.saveItems(_items);
    notifyListeners();
  }
}
