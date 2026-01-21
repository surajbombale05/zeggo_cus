import 'package:hive/hive.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';

class CartService {
     static Box<CartItem>? _box;

  static Box<CartItem> get box {
    _box ??= Hive.isBoxOpen('cartBox')
        ? Hive.box<CartItem>('cartBox')
        : null;

    if (_box == null) {
      throw Exception('cartBox not initialized');
    }
    return _box!;
  }

  static void addToCart(CartItem item) {
    if (box.containsKey(item.productId)) {
      final existing = box.get(item.productId)!;
      existing.quantity += 1;
      existing.save();
    } else {
      box.put(item.productId, item);
    }
  }

  static void increment(String productId) {
    final item = box.get(productId)!;
    item.quantity += 1;
    item.save();
  }

  static void decrement(String productId) {
    final item = box.get(productId)!;
    if (item.quantity <= 1) {
      box.delete(productId);
    } else {
      item.quantity -= 1;
      item.save();
    }
  }

  static int getQuantity(String productId) {
    return box.get(productId)?.quantity ?? 0;
  }

  static double getTotalPrice() {
    double total = 0;
    for (var item in box.values) {
      total += item.price * item.quantity;
    }
    return total;
  }

  static List<CartItem> getItems() => box.values.toList();

  
}
