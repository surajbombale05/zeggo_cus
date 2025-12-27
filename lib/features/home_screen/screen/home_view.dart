import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeggo_cus/features/home_screen/controller/home_controller.dart';
import 'package:zeggo_cus/features/home_screen/screen/product_detail_screen.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

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
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (_, i) {
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Center(child: Image.asset("assets/images/banana.png", height: 110, fit: BoxFit.contain)),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6)],
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.favorite_border, size: 22),
                                  onPressed: () {},
                                ),
                              ),
                            ),

                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                                child: const Text(
                                  "20% OFF",
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 📦 DETAILS
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Fresh Banana",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                            ),

                            const SizedBox(height: 4),

                            const Text("₹40", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),

                            const SizedBox(height: 10),

                            /// ➕ ADD BUTTON (STATIC UI)
                            SizedBox(
                              width: double.infinity,
                              height: 36,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.green),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "ADD",
                                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
