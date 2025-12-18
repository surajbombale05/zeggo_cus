import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeggo_cus/features/bottom_navigation_bar/view/bottom_navigation_bar.dart';
import 'package:zeggo_cus/features/categories/view/categories_view.dart';
import 'package:zeggo_cus/features/home_screen/controller/home_controller.dart';

import 'package:zeggo_cus/features/bottom_navigation_bar/controller/bottom_nav_controller.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_view.dart';
import 'package:zeggo_cus/features/profile_section/view/profile_view.dart';
import 'package:zeggo_cus/features/trendings/view/trending_view.dart';
import 'package:zeggo_cus/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomeView(),
    CategoriesView(),
    TrendingView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: ZeptoStyleAppBar(),
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        );
      }),

      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
