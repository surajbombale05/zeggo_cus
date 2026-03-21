import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/cart_section/cart_view.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_product_by_id/get_product_by_id_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/like_toogle/like_toogle_cubit.dart';
import 'package:zeggo_cus/utils/service/proveider/cart_provider.dart';
import 'package:zeggo_cus/utils/storage/auth_guard.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';
import 'package:zeggo_cus/widgets/custom_cached.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // final List<Map<String, String>> relatedProducts = [
  //   {"name": "Apple", "image": "assets/images/banana.png", "price": "₹60"},
  //   {"name": "Grapes", "image": "assets/images/banana.png", "price": "₹80"},
  //   {"name": "Mango", "image": "assets/images/banana.png", "price": "₹120"},
  // ];

  @override
  void initState() {
    super.initState();
    context.read<GetProductByIdCubit>().getProductById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        title: const Text("Product Details"),
        backgroundColor: AppColors.white,
        elevation: 1,
        actions: [
          // BlocBuilder<GetProductByIdCubit, GetProductByIdState>(
          //   builder: (context, state) {
          //     if(state is GetProductByIdLoadedState){
          //     return IconButton(
          //       icon: data.liked == true
          //           ? Icon(Icons.favorite, size: 18, color: Theme.of(context).primaryColor)
          //           : Icon(Icons.favorite_border, size: 18, color: Theme.of(context).primaryColor),
          //       onPressed: () {
          //         context.read<LikeToogleCubit>().like(widget.id);
          //       },
          //     );
          //   }
          //   return SizedBox();
          //   }
          // ),
        ],
      ),

      body: BlocBuilder<GetProductByIdCubit, GetProductByIdState>(
        builder: (context, state) {
          if (state is GetProductByIdLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is GetProductByIdLoadedState) {
            var data = state.model.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.white,
                    child: CustomCachedCard(imageUrl: "${AppString.baseUrl}/${data?.img}"),
                  ),

                  const SizedBox(height: 10),
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
                        Text(data?.name ?? "", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.kGreyColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(data?.category?.name ?? ""),
                            ),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.kGreyColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(data?.subcategory?.name ?? ""),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// PRICE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "₹${data?.actualPrice ?? ""}",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "₹${data?.offerPrice ?? ""}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        const Text("Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),

                        const SizedBox(height: 6),

                        Text(
                          data?.productDetails ?? "",
                          style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.all(16),
                  //   decoration: const BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text("Related Products", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),

                  //       const SizedBox(height: 10),

                  //       SizedBox(
                  //         height: 180,
                  //         child: ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount: relatedProducts.length,
                  //           itemBuilder: (context, index) {
                  //             final item = relatedProducts[index];

                  //             return Container(
                  //               width: 140,
                  //               margin: const EdgeInsets.only(right: 12),
                  //               padding: const EdgeInsets.all(10),
                  //               decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(14),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: Colors.black.withOpacity(0.05),
                  //                     blurRadius: 8,
                  //                     offset: const Offset(0, 4),
                  //                   ),
                  //                 ],
                  //               ),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Expanded(child: Center(child: Image.asset(item["image"]!, height: 70))),

                  //                   Text(
                  //                     item["name"]!,
                  //                     maxLines: 1,
                  //                     overflow: TextOverflow.ellipsis,
                  //                     style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  //                   ),

                  //                   const SizedBox(height: 4),

                  //                   Text(
                  //                     item["price"]!,
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Theme.of(context).primaryColor,
                  //                     ),
                  //                   ),

                  //                   const SizedBox(height: 6),

                  //                   SizedBox(
                  //                     width: double.infinity,
                  //                     height: 30,
                  //                     child: OutlinedButton(
                  //                       style: OutlinedButton.styleFrom(
                  //                         side: BorderSide(color: Theme.of(context).primaryColor),
                  //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  //                       ),
                  //                       onPressed: () {},
                  //                       child: Text(
                  //                         "ADD",
                  //                         style: TextStyle(
                  //                           color: Theme.of(context).primaryColor,
                  //                           fontSize: 12,
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //       SizedBox(height: 10),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),

      bottomNavigationBar: BlocBuilder<GetProductByIdCubit, GetProductByIdState>(
        builder: (context, state) {
          if (state is GetProductByIdLoadedState) {
            final data = state.model.data;
            final productId = data?.id ?? "";

            return Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: Consumer<CartProvider>(
                builder: (context, cart, _) {
                  final quantity = cart.getQuantity(productId);

                  /// 🔹 NOT IN CART
                  if (quantity == 0) {
                    return SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Theme.of(context).primaryColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          cart.add(
                            CartItem(
                              productId: productId,
                              name: data?.name ?? "",
                              image: data?.img ?? "",
                              price: double.parse(data?.offerPrice ?? "0"),
                              quantity: 1,
                              unit: data?.unit ?? "",
                            ),
                          );
                        },
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }

                  /// 🔹 IN CART → SHOW COUNTER
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Theme.of(context).primaryColor),
                                onPressed: () => cart.decrement(productId),
                              ),
                              Expanded(
                                child: Text(
                                  quantity.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                                onPressed: () => cart.increment(productId),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () async {
                              await AuthGuard.checkLogin(
                                context: context,
                                onLoggedIn: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartView()));
                                },
                              );
                            },
                            child: Text(
                              "View Cart",
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
