import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/widgets/custom_svg.dart';

class AddUpdateAddressScreen extends StatefulWidget {
  final bool isEdit;

  const AddUpdateAddressScreen({super.key, this.isEdit = false});

  @override
  State<AddUpdateAddressScreen> createState() => _AddUpdateAddressScreenState();
}

class _AddUpdateAddressScreenState extends State<AddUpdateAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedAdd = "HOME";
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Type *", style: TextStyle(fontSize: 14)),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedAdd = "HOME");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedAdd == "HOME"
                              ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
                              : AppColors.kGreyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedAdd == "HOME" ? Theme.of(context).primaryColor : AppColors.kGreyColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            CustomSvgImage(
                              imageUrl: "assets/svg/home.svg",
                              color: selectedAdd == "HOME"
                                  ? AppColors.primaryColor
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Home",
                              style: TextStyle(
                                color: selectedAdd == "HOME"
                                    ? AppColors.primaryColor
                                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedAdd = "OFFICE");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedAdd == "OFFICE"
                              ? AppColors.primaryColor.withValues(alpha: 0.15)
                              : AppColors.kGreyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedAdd == "OFFICE" ? AppColors.primaryColor : AppColors.kGreyColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            CustomSvgImage(
                              imageUrl: "assets/svg/work.svg",
                              color: selectedAdd == "OFFICE"
                                  ? AppColors.primaryColor
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Work",
                              style: TextStyle(
                                color: selectedAdd == "OFFICE"
                                    ? AppColors.primaryColor
                                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 13),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedAdd = "OTHER");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedAdd == "OTHER"
                              ? AppColors.primaryColor.withValues(alpha: 0.15)
                              : AppColors.kGreyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedAdd == "OTHER" ? AppColors.primaryColor : AppColors.kGreyColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            CustomSvgImage(
                              imageUrl: "assets/svg/location.svg",
                              color: selectedAdd == "OTHER"
                                  ? AppColors.primaryColor
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Other",
                              style: TextStyle(
                                color: selectedAdd == "OTHER"
                                    ? AppColors.primaryColor
                                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _inputField("Full Name", name),
              _inputField("Phone Number", phone, keyboardType: TextInputType.phone),
              _inputField("Full Address", address, maxLines: 3),
              _inputField("City", city),
              _inputField("Pincode", pin, keyboardType: TextInputType.number),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.isEdit ? "Update Address" : "Save Address",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller, {int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 13)),
          SizedBox(height: 5),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: (v) => v!.isEmpty ? "Required field" : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
