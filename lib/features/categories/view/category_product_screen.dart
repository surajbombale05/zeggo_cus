import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_product_by_cat_id_and_sub_id/get_all_product_by_catid_and_subcatid_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';
import 'package:zeggo_cus/features/home_screen/screen/product_detail_screen.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class CategoryProductScreen extends StatefulWidget {
  final String catId;
  final String subCatId;
  const CategoryProductScreen({super.key, required this.catId, required this.subCatId});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllProductByCatidAndSubcatidCubit>().getAllProductByCatIdAndSubId(widget.catId, widget.subCatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetAllProductByCatidAndSubcatidCubit, GetAllProductByCatidAndSubcatidState>(
        builder: (context, state) {
          if (state is GetAllProductByCatidAndSubcatidLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is GetAllProductByCatidAndSubcatidLoadedState) {
            if (state.model.data == null || state.model.data!.isEmpty) {
              return Center(
                child: Text(
                  "No Product Exist for This Category",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.model.data?.length ?? 0,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: .49,
                      ),
                      itemBuilder: (_, i) {
                        final p = state.model.data?[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ProductDetailScreen(id: p?.id ?? "")),
                            );
                          },
                          child: CustomProductCard(data: p ?? Datum()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
