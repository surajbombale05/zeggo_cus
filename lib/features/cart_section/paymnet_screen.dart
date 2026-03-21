import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/constants/app_toast.dart';
import 'package:zeggo_cus/features/home_screen/bloc/place_order/place_order_cubit.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_screen.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_view.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/get_all_address/get_all_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/get_all_address/get_all_address_model.dart';
import 'package:zeggo_cus/features/profile_section/screen/address/add_update_address.dart';
import 'package:zeggo_cus/utils/service/cart_service.dart';
import 'package:zeggo_cus/utils/service/proveider/cart_provider.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> items;
  const CheckoutScreen({super.key, required this.items});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String paymentMethod = "cod";
  Datum? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      body: Column(
        children: [
          /// PAYMENT CARD
          Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                RadioListTile(
                  value: "cod",
                  activeColor: Theme.of(context).primaryColor,
                  groupValue: paymentMethod,
                  onChanged: (value) => setState(() => paymentMethod = value!),
                  title: const Text("Cash on Delivery"),
                ),

                RadioListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: "online",
                  groupValue: paymentMethod,
                  onChanged: (value) => setState(() => paymentMethod = value!),
                  title: const Text("Pay Online"),
                ),
              ],
            ),
          ),
          _addressCard(context),
          const Spacer(),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _priceRow("Item Total", "₹120"),
                _priceRow("Delivery Fee", "₹20"),
                _priceRow("Discount", "-₹30", isDiscount: true),

                const Divider(height: 24),

                _priceRow("Grand Total", "₹110", isTotal: true),

                const SizedBox(height: 14),

                BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
                  listener: (context, state) async {
                    if (state is PlaceOrderErrorState) {
                      AppToast.showError(context, "", state.error);
                      return;
                    }
                    if (state is PlaceOrderLoadedState) {
                      AppToast.showSuccess(context, "Sucess", "Order place Sucessfully");
                      await CartService.clearCart();
                      context.read<CartProvider>().clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return (state is PlaceOrderLoadingState)
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              onPressed: () {
                                if (paymentMethod == "cod") {
                                  context.read<PlaceOrderCubit>().placeOrder(
                                    addressId: selectedAddress?.id ?? "",
                                    cartItems: widget.items,
                                    paymentMethod: "cod",
                                  );
                                } else {
                                  context.read<PlaceOrderCubit>().placeOrder(
                                    addressId: selectedAddress?.id ?? "",
                                    cartItems: widget.items,
                                    paymentMethod: "online",
                                  );
                                }
                              },
                              child: Text(
                                "Place Order",
                                style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
    );
  }

  Widget _addressCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Delivery Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),

          InkWell(
            onTap: _openAddressBottomSheet,
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    selectedAddress == null
                        ? "Select Address"
                        : "${selectedAddress!.fullAddress} ,${selectedAddress!.city}, ${selectedAddress!.phoneNo}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: isTotal ? 16 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isDiscount ? Theme.of(context).primaryColor : AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  void _openAddressBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return BlocBuilder<GetAllAddressCubit, GetAllAddressState>(
          builder: (context, state) {
            if (state is GetAllAddressLoadingState) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is GetAllAddressLoadedState) {
              if (state.model.data!.isEmpty) {
                return const Center(child: Text("No Address Found"));
              }

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(14),
                        itemCount: state.model.data!.length,
                        itemBuilder: (context, index) {
                          final item = state.model.data![index];

                          return InkWell(
                            onTap: () {
                              setState(() => selectedAddress = item);
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: _cardDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.addType ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  Text("${item.fullAddress ?? ""} ,${item.city}, ${item.phoneNo}"),
                                  const SizedBox(height: 6),
                                  Text("Phone: ${item.phoneNo ?? ""}"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsetsGeometry.all(12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddUpdateAddressScreen()),
                              );
                            },
                            child: Text(
                              "Add New Address",
                              style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        );
      },
    );
  }
}
