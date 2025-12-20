import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("🔥 Trending"),
            _categoryGrid([
              CategoryModel("Fresh Fruits", Icons.apple, Colors.redAccent),
              CategoryModel("Green Veggies", Icons.eco, Colors.green),
              CategoryModel("Organic", Icons.spa, Colors.teal),
            ]),

            const SizedBox(height: 24),

            _sectionTitle("⭐ Most Popular"),
            _categoryGrid([
              CategoryModel(
                "Daily Vegetables",
                Icons.local_florist,
                Colors.lightGreen,
              ),
              CategoryModel("Seasonal Fruits", Icons.sunny, Colors.orange),
              CategoryModel("Leafy Greens", Icons.grass, Colors.greenAccent),
            ]),

            const SizedBox(height: 24),

            _sectionTitle("🆕 New Arrivals"),
            _categoryGrid([
              CategoryModel("Exotic Fruits", Icons.star, Colors.purple),
              CategoryModel("Fresh Herbs", Icons.local_dining, Colors.brown),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _categoryGrid(List<CategoryModel> categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final item = categories[index];
        return GestureDetector(
          onTap: () {
            // Navigate to category products
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, size: 32, color: item.color),
                ),
                const SizedBox(height: 12),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryModel {
  final String title;
  final IconData icon;
  final Color color;

  CategoryModel(this.title, this.icon, this.color);
}
