import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/cart_section/paymnet_screen.dart';
import 'package:zeggo_cus/utils/service/proveider/cart_provider.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';
import 'package:zeggo_cus/widgets/custom_cached.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        final allItems = List<CartItem>.from(cart.items);
        // Sort by category priority to ensure consistent grouping
        final categoryPriority = {'grocery': 1, 'fruit': 2, 'vegetable': 3, 'nonveg': 4};
        allItems.sort((a, b) {
          int priorityA = categoryPriority[a.superCategory.toLowerCase()] ?? 100;
          int priorityB = categoryPriority[b.superCategory.toLowerCase()] ?? 100;
          return priorityA.compareTo(priorityB);
        });

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: const Text("My Cart", style: TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: allItems.isEmpty
              ? const Center(child: Text("Your cart is empty 🛒", style: TextStyle(fontSize: 16)))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: allItems.length,
                        itemBuilder: (context, index) {
                          final item = allItems[index];

                          // Visually separate categories with a header if it's the first item of that category
                          final String currentCategory = item.superCategory;
                          bool showHeader = false;
                          if (index == 0) {
                            showHeader = true;
                          } else if (allItems[index - 1].superCategory != currentCategory) {
                            showHeader = true;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (showHeader)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                  child: Text(
                                    currentCategory.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                ),
                              _cartItemCard(context, item),
                            ],
                          );
                        },
                      ),
                    ),
                    _priceSummary(context, allItems),
                  ],
                ),
        );
      },
    );
  }

  Widget _cartItemCard(BuildContext context, CartItem item) {
    final cart = context.read<CartProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: CustomCachedCard(imageUrl: "${AppString.baseUrl}/${item.image}", fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text("₹${item.price}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(item.unit, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          Container(
            height: 34,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: () => cart.decrement(item.productId),
                ),
                Text(item.quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () => cart.increment(item.productId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceSummary(BuildContext context, List<CartItem> items) {
    final itemTotal = items.fold<double>(0, (sum, e) => sum + (e.price * e.quantity));

    const double deliveryFee = 0;
    const double discount = 0;
    final grandTotal = itemTotal + deliveryFee - discount;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -6))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _priceRow("Item Total (${items.length} items)", "₹${itemTotal.toStringAsFixed(0)}"),
          _priceRow("Delivery Fee", "₹${deliveryFee.toStringAsFixed(0)}"),
          _priceRow("Discount", "-₹${discount.toStringAsFixed(0)}", isDiscount: true),
          const Divider(height: 24),
          _priceRow("Grand Total", "₹${grandTotal.toStringAsFixed(0)}", isTotal: true),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(items: items)));
              },
              child: const Text(
                "Proceed to Checkout",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: isTotal ? 16 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
