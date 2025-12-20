import 'package:flutter/material.dart';

class TrendingView extends StatelessWidget {
  const TrendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 Advertisement Banner
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xff6BCF8E), Color(0xff3BB77E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Fresh & Healthy 🍎",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Up to 30% OFF on Trending Items",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🔥 Trending Title
              const Text(
                "Trending Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              // 🥕 Products Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trendingProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final product = trendingProducts[index];
                  return _TrendingProductCard(product: product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🧩 Product Card
class _TrendingProductCard extends StatelessWidget {
  final TrendingProduct product;

  const _TrendingProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: product.bgColor.withOpacity(0.15),
                  ),
                  child: Center(
                    child: Icon(product.icon, size: 60, color: product.bgColor),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Product Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "₹${product.price}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3BB77E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 📦 Product Model
class TrendingProduct {
  final String name;
  final double price;
  final double rating;
  final IconData icon;
  final Color bgColor;

  TrendingProduct({
    required this.name,
    required this.price,
    required this.rating,
    required this.icon,
    required this.bgColor,
  });
}

// 🔥 Dummy Data
final List<TrendingProduct> trendingProducts = [
  TrendingProduct(
    name: "Fresh Apples",
    price: 120,
    rating: 4.6,
    icon: Icons.apple,
    bgColor: Colors.red,
  ),
  TrendingProduct(
    name: "Green Broccoli",
    price: 80,
    rating: 4.4,
    icon: Icons.eco,
    bgColor: Colors.green,
  ),
  TrendingProduct(
    name: "Bananas",
    price: 60,
    rating: 4.5,
    icon: Icons.rice_bowl,
    bgColor: Colors.yellow.shade700,
  ),
  TrendingProduct(
    name: "Carrots",
    price: 70,
    rating: 4.3,
    icon: Icons.local_florist,
    bgColor: Colors.orange,
  ),
];
