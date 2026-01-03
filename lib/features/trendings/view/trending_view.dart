import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/features/home_screen/screen/product_detail_screen.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class TrendingView extends StatefulWidget {
  const TrendingView({super.key});

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView> {
  final List<Map<String, dynamic>> products = [
    {"name": "Vietnamese Cold Coffee", "price": 109, "image": "https://picsum.photos/200/300"},
    {"name": "Adrak Chai", "price": 99, "image": "https://picsum.photos/200/301"},
    {"name": "Chili Cheese Toast", "price": 75, "image": "https://picsum.photos/200/302"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        surfaceTintColor: AppColors.white,
        title: const Text("Trending", style: TextStyle(fontWeight: FontWeight.w700)),
        actions: const [
          Icon(Icons.search, color: AppColors.primaryDark),
          SizedBox(width: 10),
          Icon(Icons.favorite_border, color: AppColors.primaryDark),
          SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text("Up to 30% OFF on Trending Items", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ),
              ),

              _productSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Trending Product", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: .80,
          ),
          itemBuilder: (_, i) {
            final p = products[i];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      name: "Fresh Banana",
                      image: "assets/images/banana.png",
                      price: "₹40",
                      description:
                          "Fresh bananas directly sourced from farms. Rich in nutrients and perfect for snacks, smoothies, and desserts.",
                    ),
                  ),
                );
              },
              child: CustomProductCard(p: p, index: i),
            );
          },
        ),
      ],
    );
  }
}
