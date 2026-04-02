import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_all_orders/get_all_orders_cubit.dart';
import 'package:zeggo_cus/features/profile_section/screen/order/order_detail_screen.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllOrdersCubit>().getAllOrders();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            context.read<GetAllOrdersCubit>().getAllOrders();
          },
          child: const Text("My Orders"),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: BlocBuilder<GetAllOrdersCubit, GetAllOrdersState>(
        builder: (context, state) {
          if (state is GetAllOrdersLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is GetAllOrdersLaodedState) {
            final orders = state.model.data ?? [];
            return orders.isEmpty
                ? Center(child: Text("No Orders Found !"))
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];

                      final dateTime = DateTime.parse(order.createdAt.toString());
                      final itemsText = order.items?.map((e) => e.product?.name ?? "").join(", ") ?? "";

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "#Order${order.id?.substring(0, 8) ?? ""}",
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor(order.orderStatus ?? "").withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      order.orderStatus ?? "",
                                      style: TextStyle(
                                        color: statusColor(order.orderStatus ?? ""),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor(order.orderStatus ?? "").withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      order.paymentMode ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: statusColor(order.orderStatus ?? ""),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                const Icon(Icons.calendar_month, size: 16, color: Colors.grey),
                                const SizedBox(width: 6),
                                Text(
                                  "${dateTime.day}/${dateTime.month}/${dateTime.year}",
                                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                const SizedBox(width: 6),
                                Text(
                                  TimeOfDay.fromDateTime(dateTime).format(context),
                                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Text(
                              itemsText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13, color: Colors.black87),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total: ₹${order.totalAmount ?? "0"}",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: order.id ?? "")),
                                    );
                                  },
                                  child: Text("View Details", style: TextStyle(color: Theme.of(context).primaryColor)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
          }
          return SizedBox();
        },
      ),
    );
  }
}
