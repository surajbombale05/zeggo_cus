import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeggo_cus/features/home_screen/controller/home_controller.dart';
 
class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Deliver in 10 mins ⚡"),
        actions: const [
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            _offerBanner(),
            _categorySection(),
            _productSection(),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search groceries, fruits...",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _offerBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          "⚡ Flat 30% OFF on first order",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _categorySection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: Obx(() => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) {
                    final item = controller.categories[i];
                    return Container(
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item["icon"]!, style: const TextStyle(fontSize: 26)),
                          const SizedBox(height: 6),
                          Text(item["name"]!,
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _productSection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Popular Items",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Obx(() => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.products.length,
                
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (_, i) {
                  final product = controller.products[i];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // // Expanded(
                        // //   child: Image.network(product["image"]!,
                        // //       fit: BoxFit.cover),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Banana",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text("₹${product["price"]}"),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("ADD"),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
