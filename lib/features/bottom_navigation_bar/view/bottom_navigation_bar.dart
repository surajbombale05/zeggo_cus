import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeggo_cus/features/bottom_navigation_bar/controller/bottom_nav_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.category_rounded,
    Icons.trending_up_rounded,
    Icons.hotel_class_outlined,
  ];

  final List<String> labels = ["Home", "Categories", "Trending", "Cafe"];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -4))],
        ),
        child: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.changeIndex(index),

          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,

          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,

          showUnselectedLabels: true,

          items: List.generate(icons.length, (index) {
            return BottomNavigationBarItem(icon: Icon(icons[index]), label: labels[index]);
          }),
        ),
      );
    });
  }
}
