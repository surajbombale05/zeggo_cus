import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/constants/app_toast.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/categories/view/category_product_screen.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_banner/get_all_banner_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_category/get_all_category_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_category/get_all_category_model.dart' show Datum;
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/like_toogle/like_toogle_cubit.dart';
import 'package:zeggo_cus/features/home_screen/controller/home_controller.dart';
import 'package:zeggo_cus/widgets/custom_appbar.dart';
import 'package:zeggo_cus/widgets/custom_cached.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());
  bool _showAllProducts = false;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GetAllProductsCubit>().getAllProduct();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: ZeptoStyleAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchBar(),
              _offerBanner(),
              _categorySection(),
              // _popularSection(context),
              _productSection(context),
              _catSubSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search here",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _offerBanner() {
    return const _OfferCarousel();
  }

  Widget _catSubSection() {
    return BlocBuilder<GetAllCategoryCubit, GetAllCategoryState>(
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

                  if (subCats.isNotEmpty) _subCategoryGrid(subCats, context, category.id ?? "", category.name ?? ""),

                  const SizedBox(height: 20),
                ],
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
    );
  }

  Widget _subCategoryGrid(List<Datum> subCats, BuildContext context, String categoryId, String name) {
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
                builder: (_) =>
                    CategoryProductScreen(catId: categoryId, subCatId: sub.id ?? "", subCats: subCats, catName: name),
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

  Widget _categorySection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<GetAllCategoryCubit, GetAllCategoryState>(
        builder: (context, state) {
          if (state is GetAllCategoryLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.model.data?.length ?? 0,
                    itemBuilder: (_, i) {
                      final item = state.model.data?[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryProductScreen(catId: item?.id ?? "", catName: item?.name ?? ""),
                              ),
                            );
                          },
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomCachedCard(imageUrl: "${AppString.baseUrl}/${item?.img}", height: 50),
                                const SizedBox(height: 6),
                                Text(
                                  item?.name ?? "",
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _productSection(context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<GetAllProductsCubit, GetAllProductsState>(
        builder: (context, state) {
          if (state is GetAllProductsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetAllProductsLoadedState) {
            final products = state.model.data ?? [];

            final bool hasMoreThanNine = products.length > 9;
            final displayedProducts = _showAllProducts ? products : products.take(9).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Recommended Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),

                BlocListener<LikeToogleCubit, LikeToogleState>(
                  listener: (context, state) {
                    if (state is LikeToogleErrorState) {
                      AppToast.showError(context, "Error !", state.error);
                      return;
                    }
                    if (state is LikeToogleLoadedState) {
                      AppToast.showSuccess(context, "", state.model.message);
                    }
                  },
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: displayedProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: .55,
                    ),
                    itemBuilder: (_, i) {
                      final p = displayedProducts[i];
                      return CustomProductCard(data: p);
                    },
                  ),
                ),

                if (hasMoreThanNine) ...[
                  const SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showAllProducts = !_showAllProducts;
                        });
                      },
                      child: Text(
                        _showAllProducts ? "View Less" : "View More",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  //   Widget _popularSection(context) {
  //     return Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text("Popular Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
  //           const SizedBox(height: 12),
  //           SizedBox(
  //             height: 240,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: products.length,
  //               itemBuilder: (context, i) {
  //                 final p = products[i];
  //                 return Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 4),
  //                   child: SizedBox(
  //                     width: 130,
  //                     child: CustomProductCard(p: p, index: i),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
}

class _OfferCarousel extends StatefulWidget {
  const _OfferCarousel();

  @override
  State<_OfferCarousel> createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<_OfferCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllBannerCubit, GetAllBannerState>(
      builder: (context, state) {
        if (state is GetAllBannerLoadedState && (state.model.data?.isNotEmpty ?? false)) {
          final banners = state.model.data!;

          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: banners.length,
                itemBuilder: (context, index, realIndex) {
                  final data = banners[index];

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomCachedCard(imageUrl: "${AppString.baseUrl}/${data.img ?? ""}", fit: BoxFit.fill),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
                            child: Text(
                              data.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 180,
                  viewportFraction: 0.9,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() => _currentIndex = index);
                  },
                ),
              ),

              const SizedBox(height: 8),

              /// Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(banners.length, (index) {
                  final isActive = _currentIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
