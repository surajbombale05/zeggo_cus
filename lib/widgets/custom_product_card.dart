import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/features/home_screen/screen/product_detail_screen.dart';

class CustomProductCard extends StatefulWidget {
  final Map<String, dynamic> p;
  final int index;
  final bool isLike;
  const CustomProductCard({super.key, required this.p, required this.index, this.isLike = false});

  @override
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {
  final Map<int, int> qty = {};

  void add(int index) {
    setState(() {
      qty[index] = 1;
    });
  }

  void increment(int index) {
    setState(() {
      qty[index] = (qty[index] ?? 0) + 1;
    });
  }

  void decrement(int index) {
    if ((qty[index] ?? 0) <= 1) {
      setState(() => qty.remove(index));
    } else {
      setState(() => qty[index] = qty[index]! - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: AppColors.primaryDark.withOpacity(.06), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Image.network(widget.p["image"], fit: BoxFit.cover),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: AppColors.primaryDark.withValues(alpha: .08), blurRadius: 6)],
                    ),
                    child: widget.isLike
                        ? Icon(Icons.favorite, size: 18, color: Theme.of(context).primaryColor)
                        : Icon(Icons.favorite_border, size: 18, color: Theme.of(context).primaryColor),
                  ),
                ),

                Positioned(
                  right: 5,
                  bottom: 5,
                  child: qty[widget.index] == null
                      ? GestureDetector(
                          onTap: () => add(widget.index),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                            ),
                            child: Icon(Icons.add, color: Theme.of(context).primaryColor),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => decrement(widget.index),
                                icon: const Icon(Icons.remove, size: 16),
                              ),
                              Text(
                                qty[widget.index].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => increment(widget.index),
                                icon: const Icon(Icons.add, size: 16),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "₹${widget.p["price"]}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "₹120",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    Text(
                      "10% OFF",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      widget.p["name"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "500 gm",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
