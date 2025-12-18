import 'package:flutter/material.dart';

class ZeptoStyleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ZeptoStyleAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      automaticallyImplyLeading: false,
      

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🚀 Delivery text
          Row(
            children: const [
              Text(
                "Deliver in ",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "10 mins ⚡",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 2),

          // 📍 Location row
          Row(
            children: const [
              Icon(Icons.location_on, size: 16, color: Colors.green),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Sangamner, Maharashtra",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
            ],
          ),
        ],
      ),

      actions: [
        // 🔔 Notification
        IconButton(
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),

        // 🛒 Cart with badge
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black87,
                ),
                onPressed: () {},
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
