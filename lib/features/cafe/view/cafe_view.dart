import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class CafeView extends StatefulWidget {
  const CafeView({super.key});

  @override
  State<CafeView> createState() => _CafeViewState();
}

class _CafeViewState extends State<CafeView> {
  final List<Map<String, dynamic>> products = [
    {"name": "Vietnamese Cold Coffee", "price": 109, "image": "https://picsum.photos/200/300"},
    {"name": "Adrak Chai", "price": 99, "image": "https://picsum.photos/200/301"},
    {"name": "Chili Cheese Toast", "price": 75, "image": "https://picsum.photos/200/302"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF7E8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text("Zepto Cafe"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: .83,
          ),
          itemBuilder: (_, index) {
            final p = products[index];

            return CustomProductCard(p: p, index: index);
          },
        ),
      ),
    );
  }
}
