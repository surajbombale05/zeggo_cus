import 'package:flutter/material.dart';
import 'package:zeggo_cus/features/profile_section/screen/order/order_detail_screen.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        "orderId": "#ORD12345",
        "date": "25 Dec 2025",
        "time": "10:45 AM",
        "status": "Delivered",
        "items": "Banana, Apple, Milk",
        "total": "₹240",
      },
      {
        "orderId": "#ORD12346",
        "date": "24 Dec 2025",
        "time": "08:10 PM",
        "status": "On The Way",
        "items": "Bread, Butter",
        "total": "₹120",
      },
      {
        "orderId": "#ORD12347",
        "date": "21 Dec 2025",
        "time": "02:30 PM",
        "status": "Cancelled",
        "items": "Mango, Grapes",
        "total": "₹180",
      },
    ];

    Color statusColor(String status) {
      switch (status) {
        case "Delivered":
          return Colors.green;
        case "On The Way":
          return Colors.orange;
        case "Cancelled":
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("My Orders"), backgroundColor: Colors.white, elevation: 1),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ORDER ID + STATUS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order["orderId"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor(order["status"]!).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order["status"]!,
                        style: TextStyle(
                          color: statusColor(order["status"]!),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
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
                    Text(order["date"]!, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                    const SizedBox(width: 12),
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(order["time"]!, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  order["items"]!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total: ${order["total"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailScreen(orderId: order['orderId'].toString()),
                          ),
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
      ),
    );
  }
}
