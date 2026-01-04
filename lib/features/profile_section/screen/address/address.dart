import 'package:flutter/material.dart';
import 'package:zeggo_cus/features/profile_section/screen/address/add_update_address.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int selectedAddress = 0;

  final List<Map<String, String>> addresses = [
    {
      "type": "Home",
      "name": "Sagar Khemnar",
      "address": "Flat No 203, Green Residency,\nNashik, Maharashtra - 422001",
      "phone": "9876543210",
    },
    {
      "type": "Office",
      "name": "Sagar Khemnar",
      "address": "IT Park, Hinjewadi Phase 2,\nPune, Maharashtra - 411057",
      "phone": "9876543210",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Addresses"), elevation: 1, backgroundColor: Colors.white),

      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final item = addresses[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item["type"]!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),

                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddUpdateAddressScreen(isEdit: true)),
                        );
                      },
                      icon: const Icon(Icons.edit, size: 20),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(item["name"]!, style: const TextStyle(fontWeight: FontWeight.w600)),

                const SizedBox(height: 4),

                Text(item["address"]!, style: const TextStyle(color: Colors.black54, height: 1.4)),

                const SizedBox(height: 6),

                Text("Phone: ${item["phone"]}", style: const TextStyle(color: Colors.black87)),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(14),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddUpdateAddressScreen()));
            },
            child: const Text(
              "Add New Address",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
