import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeggo_cus/features/home_screen/controller/home_controller.dart';
import 'package:zeggo_cus/features/home_screen/screen/product_detail_screen.dart';
import 'package:zeggo_cus/widgets/custom_appbar.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());
  final List<Map<String, dynamic>> products = [
    {"name": "Vietnamese Cold Coffee", "price": 109, "image": "https://picsum.photos/200/300"},
    {"name": "Adrak Chai", "price": 99, "image": "https://picsum.photos/200/301"},
    {"name": "Chili Cheese Toast", "price": 75, "image": "https://picsum.photos/200/302"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: ZeptoStyleAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_searchBar(), _offerBanner(), _categorySection(), _productSection(context)],
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _offerBanner() {
    return const _OfferCarousel();
  }

  Widget _categorySection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) {
                  final item = controller.categories[i];
                  return Container(
                    width: 80,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item["icon"]!, style: const TextStyle(fontSize: 26)),
                        const SizedBox(height: 6),
                        Text(item["name"]!, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productSection(context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Popular Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: .83,
            ),
            itemBuilder: (_, i) {
              final p = products[i];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(
                        name: "Fresh Banana",
                        image: "assets/images/banana.png",
                        price: "₹40",
                        description:
                            "Fresh bananas directly sourced from farms. Rich in nutrients and perfect for snacks, smoothies, and desserts.",
                      ),
                    ),
                  );
                },
                child: CustomProductCard(p: p, index: i),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _OfferCarousel extends StatefulWidget {
  const _OfferCarousel();

  @override
  State<_OfferCarousel> createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<_OfferCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> banners = [
    {"text": "⚡ Flat 30% OFF on first order", "color": Colors.green},
    {"text": "🔥 Free Delivery on orders above ₹199", "color": Colors.orange},
    {"text": "💥 Up to 50% OFF on daily essentials", "color": Colors.deepPurple},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  void _autoScroll() {
    if (!mounted) return;

    _currentIndex = (_currentIndex + 1) % banners.length;

    _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: banners[index]["color"], borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Text(
                    banners[index]["text"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // 🔵 Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            final bool isActive = _currentIndex == index;
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
