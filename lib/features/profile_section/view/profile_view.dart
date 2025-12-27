import 'package:flutter/material.dart';
import 'package:zeggo_cus/features/profile_section/screen/address/address.dart';
import 'package:zeggo_cus/features/profile_section/screen/order/my_order.dart';
import 'package:zeggo_cus/features/profile_section/screen/wallet/wallet.dart';
import 'package:zeggo_cus/features/profile_section/screen/wishlist_screen.dart';
import 'package:zeggo_cus/widgets/info_screen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔝 Profile Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1FA96E), Color(0xFF47D991), Color(0xFF2FB67B)],
                    stops: [0.0, 0.45, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: Color(0xff3BB77E)),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Suraj Bombale",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text("suraj@email.com", style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("🌟 Premium Member", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 📊 Quick Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    _ProfileStat(title: "Orders", value: "24"),
                    _ProfileStat(title: "Wishlist", value: "12"),
                    _ProfileStat(title: "Reviews", value: "8"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _ProfileTile(
                      icon: Icons.favorite_border,
                      title: "Wishlist",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen()));
                      },
                    ),
                    _ProfileTile(
                      icon: Icons.shopping_bag_outlined,
                      title: "My Orders",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
                      },
                    ),
                    _ProfileTile(
                      icon: Icons.location_on_outlined,
                      title: "Delivery Address",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen()));
                      },
                    ),
                    _ProfileTile(
                      icon: Icons.account_balance_wallet_outlined,
                      title: "Wallet",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
                      },
                    ),
                    _ProfileTile(icon: Icons.settings_outlined, title: "Settings", onTap: () {}),
                    _ProfileTile(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const InfoScreen(
                              title: "Help & Support",
                              content:
                                  "If you need help with orders, payments, delivery, or account issues, please contact our support team.\n\nEmail: support@example.com\nPhone: +91 98765 43210\n\nWe are available 9 AM — 9 PM.",
                            ),
                          ),
                        );
                      },
                    ),
                    _ProfileTile(
                      icon: Icons.receipt_outlined,
                      title: "Terms & Conditions",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const InfoScreen(
                              title: "Terms & Conditions",
                              content:
                                  "By using this app you agree to our terms...\n\n1. Orders once placed cannot be edited.\n2. Refunds depend on product eligibility.\n3. Misuse of wallet or offers may lead to suspension.\n\nPlease read carefully before continuing.",
                            ),
                          ),
                        );
                      },
                    ),
                    _ProfileTile(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy Policy",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const InfoScreen(
                              title: "Privacy Policy",
                              content:
                                  "We respect your privacy.\n\nWe collect data only to improve experience — such as orders, contact info, and preferences. We never sell your data to third parties.\n\nYou can request data deletion anytime.",
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete Account"),
                        content: const Text("Are you sure you want to delete account?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Delete Account"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(16)),
                    child: const Center(
                      child: Text(
                        "Delete Account",
                        style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(16)),
                    child: const Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String title;
  final String value;

  const _ProfileStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff3BB77E)),
            ),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// 🧩 Profile Option Tile
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final String title;

  const _ProfileTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 6)),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xff3BB77E)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
