import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:zeggo_cus/constants/app_colors.dart';

import 'package:zeggo_cus/features/cart_section/cart_view.dart';
import 'package:zeggo_cus/features/profile_section/view/profile_view.dart';

class ZeptoStyleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ZeptoStyleAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      automaticallyImplyLeading: false,

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Deliver in ",
                style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
              ),
              Text(
                "10 mins ⚡",
                style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Theme.of(context).primaryColor),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Sangamner, Maharashtra",
                  style: TextStyle(fontSize: 13, color: AppColors.primaryDark, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryDark),
            ],
          ),
        ],
      ),

      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const ProfileView();
                },
              ),
            );
          },
          child: Icon(Icons.account_circle_outlined, color: Colors.black87, size: 35),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: Theme.of(context).primaryColor),
            position: badges.BadgePosition.custom(end: 0),
            badgeContent: Text("0", style: TextStyle(color: AppColors.white)),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CartView();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
