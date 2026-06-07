import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_order_by_id/get_order_by_id_cubit.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetOrderByIdCubit>().getOrderById(widget.orderId);
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.grey;

      case "processing":
        return Colors.blue;

      case "shipped":
        return Colors.orange;

      case "delivered":
        return Colors.green;

      case "cancelled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  String statusText(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return "Pending";

      case "processing":
        return "Processing";

      case "shipped":
        return "On The Way";

      case "delivered":
        return "Delivered";

      case "cancelled":
        return "Cancelled";

      default:
        return status;
    }
  }

  Widget deliveryOtpBox(String otp) {
    final digits = otp.padRight(4).split('');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_clock, color: Colors.green.shade700),
              const SizedBox(width: 8),
              const Text("Delivery OTP", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ],
          ),

          const SizedBox(height: 6),

          const Text("Share this OTP with delivery partner", style: TextStyle(color: Colors.grey, fontSize: 13)),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: digits.map((digit) {
              return Container(
                width: 58,
                height: 62,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.green.shade300, width: 1.3),
                ),
                child: Text(
                  digit,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                    letterSpacing: 1,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Order Details"),
        elevation: 1,
        backgroundColor: Colors.white,
        actions: [
          // InkWell(
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => TrackingScreen()));
          //   },
          //   child: Text("Track Order", style: TextStyle(color: AppColors.primaryColor)),
          // ),
          // SizedBox(width: 10),
        ],
      ),

      body: BlocBuilder<GetOrderByIdCubit, GetOrderByIdState>(
        builder: (context, state) {
          if (state is GetOrderByIdLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is GetOrderByIdErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is GetOrderByIdLoadedState) {
            final order = state.model.data;
            final dateTime = DateTime.parse(order?.createdAt.toString() ?? "");

            final items = order?.items ?? [];
            final address = order?.address;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "#Order${order?.id?.substring(0, 8) ?? ""}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month, size: 16, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              "${dateTime.day}/${dateTime.month}/${dateTime.year} | ${TimeOfDay.fromDateTime(dateTime).format(context)}",
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  _sectionTitle("Delivery Verification"),

                  deliveryOtpBox(order?.verificationOtp?.toString() ?? "0000"),
      const SizedBox(height: 12),
                  _sectionTitle("Order Status"),
                  _sectionCard(child: _timeline(order?.orderStatus ?? "")),

                  const SizedBox(height: 12),

                  _sectionTitle("Items"),
                  _sectionCard(
                    child: Column(
                      children: items.map<Widget>((item) {
                        final product = item.product;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              // IMAGE
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "${AppString.baseUrl}/${product?.img ?? ""}",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),

                              // NAME + QTY
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product?.name ?? "", style: const TextStyle(fontWeight: FontWeight.w600)),
                                    Text(
                                      "Qty: ${item.quantity}",
                                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),

                              // PRICE
                              Text("₹${item.price}", style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _sectionTitle("Payment Mode"),
                  _sectionCard(child: Text(order?.paymentMode == "cash_on_delivery" ? "COD" : "ONLINE")),
                  const SizedBox(height: 12),
                  // PAYMENT
                  _sectionTitle("Payment Summary"),
                  _sectionCard(
                    child: Column(
                      children: [
                        _priceRow("Subtotal", "₹${order?.totalAmount ?? "0"}"),
                        _priceRow("Delivery Fee", "₹${order?.deliveryFee ?? "0"}"),
                        const Divider(),
                        _priceRow(
                          "Grand Total",
                          "₹${(double.tryParse(order?.totalAmount ?? "0") ?? 0) + (double.tryParse(order?.deliveryFee ?? "0") ?? 0)}",
                          isBold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ADDRESS (if API gives later)
                  _sectionTitle("Delivery Address"),
                  _sectionCard(
                    child: address == null
                        ? const Text("Address not available")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 👤 Name
                              Text(
                                address.fullName ?? "",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),

                              const SizedBox(height: 4),

                              // 📞 Phone
                              Text(address.phoneNo ?? "", style: const TextStyle(color: Colors.black54)),

                              const SizedBox(height: 8),

                              // 📍 Address
                              Text(
                                "${address.fullAddress ?? ""}, ${address.city ?? ""} - ${address.zipCode ?? ""}",
                                style: const TextStyle(height: 1.4),
                              ),

                              const SizedBox(height: 6),

                              // 🏷 Address Type (optional)
                              if (address.addType != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(address.addType!.toUpperCase(), style: const TextStyle(fontSize: 12)),
                                ),
                              const SizedBox(height: 10),
                            ],
                          ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _timeline(String status) {
    final steps = ["pending", "processing", "shipped", "delivered"];

    int currentIndex = steps.indexOf(status.toLowerCase());

    return Column(
      children: List.generate(steps.length, (i) {
        final isDone = i <= currentIndex;
        final isLast = i == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(color: isDone ? Colors.green : Colors.grey, shape: BoxShape.circle),
                  child: isDone ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
                ),
                if (!isLast) Container(height: 40, width: 2, color: isDone ? Colors.green : Colors.grey),
              ],
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                statusText(steps[i]),
                style: TextStyle(fontSize: 14, fontWeight: isDone ? FontWeight.w600 : FontWeight.w400),
              ),
            ),
          ],
        );
      }),
    );
  }
}

/// ---- Reusable widgets -----

Widget _sectionCard({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
    ),
    child: child,
  );
}

Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6, left: 2),
    child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
  );
}

class _priceRow extends StatelessWidget {
  final String title;
  final String amount;
  final bool isBold;

  const _priceRow(this.title, this.amount, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(amount, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
        ],
      ),
    );
  }
}
