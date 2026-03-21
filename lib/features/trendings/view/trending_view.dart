import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_trending/get_all_trending_cubit.dart';
import 'package:zeggo_cus/features/home_screen/screen/product_detail_screen.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class TrendingView extends StatefulWidget {
  const TrendingView({super.key});

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        surfaceTintColor: AppColors.white,
        title: const Text("Trending", style: TextStyle(fontWeight: FontWeight.w700)),
        actions: const [
          Icon(Icons.search, color: AppColors.primaryDark),
          SizedBox(width: 10),
          Icon(Icons.favorite_border, color: AppColors.primaryDark),
          SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xff6BCF8E), Color(0xff3BB77E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Fresh & Healthy 🍎",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text("Up to 30% OFF on Trending Items", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ),
              ),

              _productSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productSection(context) {
    return BlocBuilder<GetAllTrendingCubit, GetAllTrendingState>(
      builder: (context, state) {
        if (state is GetAllTrendingLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is GetAllTrendingLoadedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Trending Product", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.model.data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: .55,
                ),
                itemBuilder: (_, i) {
                  final p = state.model.data?[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(
                         id: p?.id ?? "",
                          ),
                        ),
                      );
                    },
                    child: CustomProductCard(data: p ?? Datum(),),
                  );
                },
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
