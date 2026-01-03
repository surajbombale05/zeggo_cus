import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/features/categories/view/category_product_screen.dart';
import 'package:zeggo_cus/widgets/custom_cached.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Grocery & Kitchen"),
            SizedBox(height: 10),
            gridSection([
              catItem("Fruits & Vegetables", "https://picsum.photos/120/101", context),
              catItem("Dairy, Bread & Eggs", "https://picsum.photos/120/102", context),
              catItem("Atta, Rice, Oil & Dals", "https://picsum.photos/120/103", context),
              catItem("Meat, Fish & Eggs", "https://picsum.photos/120/104", context),
              catItem("Masala & Dry Fruits", "https://picsum.photos/120/105", context),
              catItem("Breakfast & Sauces", "https://picsum.photos/120/106", context),
              catItem("Packaged Food", "https://picsum.photos/120/107", context),
            ]),

            sectionTitle("Snacks & Drinks"),
            SizedBox(height: 10),
            gridSection([
              catItem("Zepto Cafe", "https://picsum.photos/120/108", context),
              catItem("Tea, Coffee & More", "https://picsum.photos/120/109", context),
              catItem("Ice Creams & More", "https://picsum.photos/120/110", context),
              catItem("Frozen Food", "https://picsum.photos/120/111", context),
              catItem("Sweet Cravings", "https://picsum.photos/120/112", context),
              catItem("Cold Drinks & Juices", "https://picsum.photos/120/113", context),
              catItem("Munchies", "https://picsum.photos/120/114", context),
              catItem("Biscuits & Cookies", "https://picsum.photos/120/115", context),
            ]),

            sectionTitle("Fashion & Lifestyle"),
            SizedBox(height: 10),
            gridSection([
              catItem("Mens Wear", "https://picsum.photos/120/116", context),
              catItem("Women Fashion", "https://picsum.photos/120/117", context),
              catItem("Kids Wear", "https://picsum.photos/120/118", context),
            ]),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
    );
  }

  Widget gridSection(List<Widget> children) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: .70,
      children: children,
    );
  }

  Widget catItem(String label, String imageUrl, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductScreen(imageUrl: imageUrl, name: label),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
            clipBehavior: Clip.antiAlias,
            child: CustomCachedCard(imageUrl: imageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
