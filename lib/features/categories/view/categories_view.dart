import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/categories/view/category_product_screen.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_category/get_all_category_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_category/get_all_category_model.dart';
import 'package:zeggo_cus/widgets/custom_cached.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<GetAllCategoryCubit>().getAllCategory();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          surfaceTintColor: AppColors.white,
          title: const Text("All Categories", style: TextStyle(fontWeight: FontWeight.w700)),
          actions: const [
            Icon(Icons.search, color: AppColors.primaryDark),
            SizedBox(width: 10),
            Icon(Icons.favorite_border, color: AppColors.primaryDark),
            SizedBox(width: 12),
          ],
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: BlocBuilder<GetAllCategoryCubit, GetAllCategoryState>(
            builder: (context, state) {
              if (state is GetAllCategoryLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetAllCategoryErrorState) {
                return Center(child: Text(state.error));
              }

              if (state is GetAllCategoryLoadedState) {
                final categories = state.model.data ?? [];

                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(14),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final subCats = category.subcategories ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(category.name ?? ""),

                        if (subCats.isNotEmpty) _subCategoryGrid(subCats, context, category.id ?? "",category.name ?? ""),

                        const SizedBox(height: 20),
                      ],
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
    );
  }

  Widget _subCategoryGrid(List<Datum> subCats, BuildContext context, String categoryId,String name) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subCats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.60,
      ),
      itemBuilder: (context, index) {
        final sub = subCats[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryProductScreen(catId: categoryId, subCatId: sub.id ?? "",subCats: subCats,catName: name ,),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.antiAlias,
                child: CustomCachedCard(imageUrl: "${AppString.baseUrl}/${sub.img ?? ""}", fit: BoxFit.cover),
              ),
              const SizedBox(height: 6),
              Text(
                sub.name ?? "",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );
  }
}
