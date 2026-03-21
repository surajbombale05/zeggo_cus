import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_all_wishlist/get_all_wishlist_cubit.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllWishlistCubit>().getAllWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("My Wishlist"), backgroundColor: Colors.white, elevation: 1),

      body: BlocBuilder<GetAllWishlistCubit, GetAllWishlistState>(
        builder: (context, state) {
          if (state is GetAllWishlistErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is GetAllWishlistLoadedState) {
            return GridView.builder(
              itemCount: state.model.data?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: .55,
              ),
              itemBuilder: (_, i) {
                final p = state.model.data?[i].product;
                return CustomProductCard(data: p ?? Datum());
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  // Widget _emptyView() {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.all(24),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: const [
  //           Icon(Icons.favorite_border, size: 70, color: Colors.grey),
  //           SizedBox(height: 14),
  //           Text("Your wishlist is empty", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
  //           SizedBox(height: 6),
  //           Text("Add products to save them for later.", style: TextStyle(color: Colors.black54)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
