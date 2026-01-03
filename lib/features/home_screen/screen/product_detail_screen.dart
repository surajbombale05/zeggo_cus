import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final String description;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final List<Map<String, String>> relatedProducts = [
    {"name": "Apple", "image": "assets/images/banana.png", "price": "₹60"},
    {"name": "Grapes", "image": "assets/images/banana.png", "price": "₹80"},
    {"name": "Mango", "image": "assets/images/banana.png", "price": "₹120"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        title: const Text("Product Details"),
        backgroundColor: AppColors.white,
        elevation: 1,
        actions: [IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {})],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.white,
              child: Center(child: Image.asset(widget.image, height: 180, fit: BoxFit.contain)),
            ),

            const SizedBox(height: 10),

            /// DETAILS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// NAME
                  Text(widget.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),

                  const SizedBox(height: 6),

                  /// ⭐ RATING
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      Icon(Icons.star_half, color: Colors.amber, size: 18),
                      Icon(Icons.star_border, color: Colors.amber, size: 18),
                      SizedBox(width: 6),
                      Text("(4.2)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// PRICE
                  Text(
                    widget.price,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),

                  const SizedBox(height: 14),

                  const Text("Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),

                  const SizedBox(height: 6),

                  Text(widget.description, style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 18),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Related Products", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: relatedProducts.length,
                      itemBuilder: (context, index) {
                        final item = relatedProducts[index];

                        return Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Center(child: Image.asset(item["image"]!, height: 70))),

                              Text(
                                item["name"]!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                item["price"]!,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                              ),

                              const SizedBox(height: 6),

                              SizedBox(
                                width: double.infinity,
                                height: 30,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Theme.of(context).primaryColor),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "ADD",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(0, 48),
                ),
                onPressed: () {},
                child: Text(
                  "Add to Cart",
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //   const SizedBox(width: 10),
            // Expanded(
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Theme.of(context).primaryColor,
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //       minimumSize: const Size(0, 48),
            //     ),
            //     onPressed: () {},
            //     child: const Text(
            //       "Buy Now",
            //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
