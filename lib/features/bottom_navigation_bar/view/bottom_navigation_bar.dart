import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeggo_cus/features/bottom_navigation_bar/controller/bottom_nav_controller.dart';
 
class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({super.key});

  final BottomNavController controller =
      Get.put(BottomNavController());

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.category_rounded,
    Icons.trending_up_rounded,
    Icons.person_rounded,
  ];

  final List<String> labels = [
    "Home",
    "Categories",
    "Trending",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            final isSelected = controller.currentIndex.value == index;

            return GestureDetector(
              onTap: () => controller.changeIndex(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      icons[index],
                      size: 26,
                      color: isSelected
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 6),
                      Text(
                        labels[index],
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
