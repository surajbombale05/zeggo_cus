import 'package:flutter/material.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Map<String, dynamic>> products = [
    {"name": "Vietnamese Cold Coffee", "price": 109, "image": "https://picsum.photos/200/300"},
    {"name": "Adrak Chai", "price": 99, "image": "https://picsum.photos/200/301"},
    {"name": "Chili Cheese Toast", "price": 75, "image": "https://picsum.photos/200/302"},
    {"name": "Vietnamese Cold Coffee", "price": 109, "image": "https://picsum.photos/200/300"},
    {"name": "Adrak Chai", "price": 99, "image": "https://picsum.photos/200/301"},
    {"name": "Chili Cheese Toast", "price": 75, "image": "https://picsum.photos/200/302"},
    {"name": "Vietnamese Cold Coffee", "price": 109, "image": "https://picsum.photos/200/300"},
    {"name": "Adrak Chai", "price": 99, "image": "https://picsum.photos/200/301"},
    {"name": "Chili Cheese Toast", "price": 75, "image": "https://picsum.photos/200/302"},
    {"name": "Vietnamese Cold Coffee", "price": 109, "image": "https://picsum.photos/200/300"},
    {"name": "Adrak Chai", "price": 99, "image": "https://picsum.photos/200/301"},
    {"name": "Chili Cheese Toast", "price": 75, "image": "https://picsum.photos/200/302"},
    {"name": "Vietnamese Cold Coffee", "price": 109, "image": "https://picsum.photos/200/300"},
    {"name": "Adrak Chai", "price": 99, "image": "https://picsum.photos/200/301"},
    {"name": "Chili Cheese Toast", "price": 75, "image": "https://picsum.photos/200/302"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("My Wishlist"), backgroundColor: Colors.white, elevation: 1),

      body: products.isEmpty
          ? _emptyView()
          : GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: .49,
              ),
              itemBuilder: (_, i) {
                final p = products[i];
                return CustomProductCard(p: p, index: i, isLike: true);
              },
            ),
    );
  }

  Widget _emptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite_border, size: 70, color: Colors.grey),
            SizedBox(height: 14),
            Text("Your wishlist is empty", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            SizedBox(height: 6),
            Text("Add products to save them for later.", style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
