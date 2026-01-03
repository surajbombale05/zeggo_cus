import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';

class CustomProductCard extends StatefulWidget {
  final Map<String, dynamic> p;
  final int index;
  const CustomProductCard({super.key, required this.p, required this.index});

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
    return Container(
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
                  height: 100,
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
                  child: Icon(Icons.favorite_border, size: 18),
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
                  Text("₹${widget.p["price"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                  const SizedBox(height: 4),

                  Text(
                    widget.p["name"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),

                  const Spacer(),

                  SizedBox(
                    height: 36,
                    width: double.infinity,
                    child: qty[widget.index] == null
                        ? OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Theme.of(context).primaryColor),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () => add(widget.index),
                            child: Text(
                              "ADD",
                              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () => decrement(widget.index),
                                  icon: const Icon(Icons.remove, size: 18),
                                ),

                                Text(
                                  qty[widget.index].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () => increment(widget.index),
                                  icon: const Icon(Icons.add, size: 18),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
