import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zeggo_cus/features/cart_section/cart_view.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/get_all_address/get_all_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/screen/address/add_update_address.dart';
import 'package:zeggo_cus/features/profile_section/view/profile_view.dart';
import 'package:zeggo_cus/utils/service/proveider/cart_provider.dart';
import 'package:zeggo_cus/utils/storage/auth_guard.dart';

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
          BlocBuilder<GetAllAddressCubit, GetAllAddressState>(
            builder: (context, state) {
              if (state is GetAllAddressLoadedState) {
                final addresses = state.model.data ?? [];

                if (addresses.isEmpty) {
                  return _emptyAddress(context);
                }

                final primaryAddress = addresses.firstWhere((e) => e.isPrimary == true, orElse: () => addresses.first);

                final addressText = "${primaryAddress.city ?? ""}, ${primaryAddress.zipCode ?? ""}";

                return Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        addressText,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                );
              }

              if (state is GetAllAddressLoadingState) {
                return const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2));
              }

              return _emptyAddress(context);
            },
          ),
        ],
      ),

      actions: [
        GestureDetector(
          onTap: () async {
           await AuthGuard.checkLogin(
              context: context,
              onLoggedIn: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ProfileView();
                    },
                  ),
                );
              },
            );
          },
          child: Icon(Icons.account_circle_outlined, color: Colors.black87, size: 35),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Consumer<CartProvider>(
            builder: (context, cart, _) {
              final totalCount = cart.items.length;

              final cartIcon = IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87, size: 30),
                onPressed: () async {
                await  AuthGuard.checkLogin(
                    context: context,
                    onLoggedIn: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CartView()));
                    },
                  );
                },
              );

              if (totalCount == 0) {
                return cartIcon;
              }

              return badges.Badge(
                badgeStyle: badges.BadgeStyle(badgeColor: Theme.of(context).primaryColor),
                position: badges.BadgePosition.topEnd(top: -4, end: -4),
                badgeContent: Text(totalCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 12)),
                child: cartIcon,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _emptyAddress(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddUpdateAddressScreen()));
      },
      child: Row(
        children: const [
          Icon(Icons.location_on_outlined, size: 16),
          SizedBox(width: 4),
          Text("Select Address", style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
