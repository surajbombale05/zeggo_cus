import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final order = {
      "orderId": orderId,
      "date": "25 Dec 2025",
      "time": "10:45 AM",
      "status": "Delivered",
      "total": "₹240",
      "address": "Sagar Khemnar\nFlat No 203, Green Residency,\nNashik, Maharashtra - 422001",
      "items": [
        {"name": "Banana", "qty": "2 kg", "price": "₹80"},
        {"name": "Apple", "qty": "1 kg", "price": "₹120"},
        {"name": "Milk", "qty": "1 litre", "price": "₹40"},
      ],
    };

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text("Order Details"), elevation: 1, backgroundColor: Colors.white),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ORDER HEADER
            _sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order["orderId"].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text("${order["date"]}  |  ${order["time"]}", style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // TIMELINE
            _sectionTitle("Order Timeline"),
            _sectionCard(child: _timeline()),

            const SizedBox(height: 12),

            // ITEMS
            _sectionTitle("Items"),
            _sectionCard(
              child: Column(
                children: (order["items"] as List).map((item) {
                  final map = item as Map<String, String>;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("${map["name"]}  (${map["qty"]})", style: const TextStyle(fontSize: 14))),
                        Text(map["price"]!, style: const TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // TOTAL
            _sectionTitle("Payment Summary"),
            _sectionCard(
              child: Column(
                children: const [
                  _priceRow("Subtotal", "₹220"),
                  _priceRow("Delivery Fee", "₹20"),
                  Divider(),
                  _priceRow("Grand Total", "₹240", isBold: true),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ADDRESS
            _sectionTitle("Delivery Address"),
            _sectionCard(child: Text(order["address"]!.toString(), style: const TextStyle(height: 1.4))),
          ],
        ),
      ),
    );
  }

  Widget _timeline() {
    final steps = [
      {"label": "Order Placed", "done": true},
      {"label": "Packed", "done": true},
      {"label": "Shipped", "done": true},
      {"label": "Delivered", "done": true},
    ];

    return Column(
      children: List.generate(steps.length, (i) {
        final step = steps[i];
        final isLast = i == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Indicator
            Column(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: (step["done"] as bool) ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 14),
                ),
                if (!isLast) Container(height: 40, width: 2, color: Colors.green),
              ],
            ),
            const SizedBox(width: 10),
            // Label
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                step["label"]!.toString(),
                style: TextStyle(fontSize: 14, fontWeight: (step["done"] as bool) ? FontWeight.w600 : FontWeight.w400),
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
