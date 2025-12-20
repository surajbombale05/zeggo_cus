import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _sectionTitle("Today"),
          _notificationCard(
            icon: Icons.local_offer_rounded,
            iconColor: Colors.green,
            title: "Flat 30% OFF 🎉",
            subtitle: "Get flat 30% OFF on your first order.",
            time: "2 min ago",
            isUnread: true,
          ),
          _notificationCard(
            icon: Icons.shopping_bag_rounded,
            iconColor: Colors.blue,
            title: "Order Delivered",
            subtitle: "Your order #1245 has been delivered.",
            time: "1 hr ago",
          ),

          const SizedBox(height: 16),

          _sectionTitle("Yesterday"),
          _notificationCard(
            icon: Icons.notifications_active_rounded,
            iconColor: Colors.orange,
            title: "New Items Added",
            subtitle: "Fresh fruits & veggies are now available.",
            time: "Yesterday",
          ),
          _notificationCard(
            icon: Icons.payment_rounded,
            iconColor: Colors.purple,
            title: "Payment Successful",
            subtitle: "₹249 paid successfully via UPI.",
            time: "Yesterday",
          ),
        ],
      ),
    );
  }

  /// 🏷 Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  /// 🔔 Notification Card
  Widget _notificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    bool isUnread = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnread ? Colors.green.withOpacity(0.08) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          /// TIME
          Text(
            time,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
