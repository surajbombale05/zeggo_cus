import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  List<Datum> allProducts = [];
  List<Datum> filteredProducts = [];

  @override
  void initState() {
    super.initState();
  }

  void _search(String value) {
    setState(() {
      if (value.isEmpty) {
        filteredProducts = allProducts;
      } else {
        filteredProducts = allProducts
            .where(
              (p) => (p.name ?? "").toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          autofocus: true,
          onChanged: _search,
          decoration: InputDecoration(
            hintText: "Search products...",
            border: InputBorder.none,
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      _search("");
                    },
                  )
                : null,
          ),
        ),
      ),
      body: BlocBuilder<GetAllProductsCubit, GetAllProductsState>(
        builder: (context, state) {
          if (state is GetAllProductsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetAllProductsLoadedState) {
            allProducts = state.model.data ?? [];

            if (filteredProducts.isEmpty && controller.text.isEmpty) {
              filteredProducts = allProducts;
            }

            if (filteredProducts.isEmpty) {
              return const Center(child: Text("No products found"));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: .55,
              ),
              itemBuilder: (_, i) {
                final product = filteredProducts[i];
                return CustomProductCard(data: product);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
