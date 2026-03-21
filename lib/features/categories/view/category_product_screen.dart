import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_product_by_cat_id_and_sub_id/get_all_product_by_catid_and_subcatid_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';
import 'package:zeggo_cus/features/home_screen/screen/product_detail_screen.dart';
import 'package:zeggo_cus/widgets/custom_cached.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_category/get_all_category_model.dart' as cat;

class CategoryProductScreen extends StatefulWidget {
  final String catId;
  final String catName;
  final List<cat.Datum>? subCats;
  final String? subCatId;
  const CategoryProductScreen({super.key, required this.catId, this.subCatId, this.subCats, required this.catName});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  late String selectedSubCatId;
  @override
  void initState() {
    super.initState();
    selectedSubCatId = widget.subCatId ?? "";
    context.read<GetAllProductByCatidAndSubcatidCubit>().getAllProductByCatIdAndSubId(
      widget.catId,
      widget.subCatId ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyActions: true, title: Text(widget.catName)),
      body: Row(
        children: [
          widget.subCats?.isEmpty ?? true
              ? SizedBox()
              : Container(
                  width: 110,
                  color: Colors.grey.shade100,
                  child: ListView.builder(
                    itemCount: widget.subCats?.length,
                    itemBuilder: (context, index) {
                      final sub = widget.subCats?[index];
                      final isSelected = sub?.id == selectedSubCatId;

                      return GestureDetector(
                        onTap: () {
                          if (selectedSubCatId == sub?.id) return;
                          setState(() {
                            selectedSubCatId = sub?.id ?? "";
                          });
                          context.read<GetAllProductByCatidAndSubcatidCubit>().getAllProductByCatIdAndSubId(
                            widget.catId,
                            selectedSubCatId,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            border: Border(
                              left: BorderSide(
                                color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                                width: 4,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                    border: isSelected
                                        ? Border.all(color: Theme.of(context).primaryColor, width: 1.5)
                                        : null,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CustomCachedCard(
                                    imageUrl: "${AppString.baseUrl}/${sub?.img ?? ""}",
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                const SizedBox(height: 6),
                                Text(
                                  sub?.name ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                                    color: isSelected ? Theme.of(context).primaryColor : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

          /// 🔹 RIGHT SIDE → PRODUCT LIST
          Expanded(
            child: BlocBuilder<GetAllProductByCatidAndSubcatidCubit, GetAllProductByCatidAndSubcatidState>(
              builder: (context, state) {
                if (state is GetAllProductByCatidAndSubcatidLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is GetAllProductByCatidAndSubcatidLoadedState) {
                  if (state.model.data == null || state.model.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Product Exist for This Category",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.model.data?.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.subCats?.isEmpty ?? true ? 3 : 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: .55,
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
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
