import 'package:flutter/material.dart';

class AddUpdateAddressScreen extends StatefulWidget {
  final bool isEdit;

  const AddUpdateAddressScreen({super.key, this.isEdit = false});

  @override
  State<AddUpdateAddressScreen> createState() =>
      _AddUpdateAddressScreenState();
}

class _AddUpdateAddressScreenState extends State<AddUpdateAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit Address" : "Add Address"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _inputField("Full Name", name),
              _inputField("Phone Number", phone,
                  keyboardType: TextInputType.phone),
              _inputField("Full Address", address, maxLines: 3),
              _inputField("City", city),
              _inputField("Pincode", pin,
                  keyboardType: TextInputType.number),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.isEdit ? "Update Address" : "Save Address",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (v) => v!.isEmpty ? "Required field" : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
