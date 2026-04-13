import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';
import 'package:get/get.dart';
import 'package:zeggo_cus/features/bottom_navigation_bar/view/bottom_navigation_bar.dart';
import 'package:zeggo_cus/features/categories/view/categories_view.dart';
import 'package:zeggo_cus/features/bottom_navigation_bar/controller/bottom_nav_controller.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_banner/get_all_banner_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_cafe/get_all_cafe_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_category/get_all_category_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_trending/get_all_trending_cubit.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_view.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/get_all_address/get_all_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_profile/get_profile_cubit.dart';
import 'package:zeggo_cus/features/profile_section/screen/order/my_order.dart';
import 'package:zeggo_cus/features/profile_section/view/profile_view.dart';
import 'package:zeggo_cus/features/trendings/view/trending_view.dart';
import 'package:zeggo_cus/utils/location/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [HomeView(), CategoriesView(), TrendingView(), MyOrders(),ProfileView()];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      LocationService.ensureLocationEnabled(context);
      context.read<GetAllProductsCubit>().getAllProduct();
      context.read<GetAllCategoryCubit>().getAllCategory();
      context.read<GetAllTrendingCubit>().getAllTrendingProduct();
      context.read<GetAllCafeCubit>().getAllCafeProduct();
      context.read<GetProfileCubit>().getProfile();
      context.read<GetAllBannerCubit>().getAllBanner();
      context.read<GetAllAddressCubit>().getAllAddress();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: ZeptoStyleAppBar(),
      body: Obx(() {
        return IndexedStack(index: controller.currentIndex.value, children: pages);
      }),
      bottomNavigationBar: CustomBottomNavigationBar(),
    ),);
  }
}
