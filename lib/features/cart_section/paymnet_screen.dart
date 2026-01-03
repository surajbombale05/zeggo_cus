import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String paymentMethod = "cod";

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

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      if (paymentMethod == "cod") {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text("Order placed with Cash on Delivery")));
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text("Redirecting to online payment...")));
                      }
                    },
                    child:  Text(
                      "Place Order",
                      style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
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
              color: isDiscount ?  Theme.of(context).primaryColor : AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
