import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeggo_cus/features/bottom_navigation_bar/view/bottom_navigation_bar.dart';
import 'package:zeggo_cus/features/cafe/view/cafe_view.dart';
import 'package:zeggo_cus/features/categories/view/categories_view.dart';
import 'package:zeggo_cus/features/bottom_navigation_bar/controller/bottom_nav_controller.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_view.dart';
import 'package:zeggo_cus/features/trendings/view/trending_view.dart';
import 'package:zeggo_cus/utils/location/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [HomeView(), CategoriesView(), TrendingView(), CafeView()];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await LocationService.ensureLocationEnabled();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: ZeptoStyleAppBar(),
      body: Obx(() {
        return IndexedStack(index: controller.currentIndex.value, children: pages);
      }),

      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
