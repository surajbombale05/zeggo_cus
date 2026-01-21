import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';
import 'package:zeggo_cus/features/home_screen/screen/product_detail_screen.dart';
import 'package:zeggo_cus/utils/service/cart_service.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';
import 'package:zeggo_cus/widgets/custom_cached.dart';

class CustomProductCard extends StatefulWidget {
  final Datum data;
  const CustomProductCard({super.key, required this.data});

  @override
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(id: widget.data.id ?? "")));
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
                    child: CustomCachedCard(
                      imageUrl: "${AppString.baseUrl}/${widget.data.img ?? ""}",
                      fit: BoxFit.cover,
                    ),
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
                    child: widget.data.actualPrice == ""
                        ? Icon(Icons.favorite, size: 18, color: Theme.of(context).primaryColor)
                        : Icon(Icons.favorite_border, size: 18, color: Theme.of(context).primaryColor),
                  ),
                ),

                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Builder(
                    builder: (_) {
                      if (!Hive.isBoxOpen('cartBox')) {
                        return const SizedBox.shrink();
                      }
                      return ValueListenableBuilder(
                        valueListenable: CartService.box.listenable(),
                        builder: (context, Box<CartItem> box, _) {
                          final quantity = CartService.getQuantity(widget.data.id ?? "");

                          if (quantity == 0) {
                            return GestureDetector(
                              onTap: () {
                                CartService.addToCart(
                                  CartItem(
                                    productId: widget.data.id ?? "",
                                    name: widget.data.name ?? "",
                                    price: double.parse(widget.data.offerPrice ?? "0"),
                                    image: widget.data.img ?? "",
                                    unit: widget.data.unit ?? "",
                                    quantity: 1,
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                                ),
                                child: Icon(Icons.add, color: Theme.of(context).primaryColor),
                              ),
                            );
                          }
                          return Container(
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
                                  onPressed: () => CartService.decrement(widget.data.id ?? ""),
                                  icon: const Icon(Icons.remove, size: 16),
                                ),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => CartService.increment(widget.data.id ?? ""),
                                  icon: const Icon(Icons.add, size: 16),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "₹${widget.data.offerPrice ?? ""}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "₹${widget.data.actualPrice ?? ""}",
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
                    "${widget.data.percentOff ?? ""}% OFF",
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    widget.data.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.data.unit ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
