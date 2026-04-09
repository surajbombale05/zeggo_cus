import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/constants/app_toast.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/delete_address/delete_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/get_all_address/get_all_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/screen/address/add_update_address.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Addresses"), elevation: 1, backgroundColor: Colors.white),

      body: BlocBuilder<GetAllAddressCubit, GetAllAddressState>(
        builder: (context, state) {
          if (state is GetAllAddressLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is GetAllAddressErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is GetAllAddressLoadedState) {
            return state.model.data?.isEmpty ?? true
                ? Center(child: Text("No Address Added Yet !"))
                : ListView.builder(
                    padding: const EdgeInsets.all(14),
                    itemCount: state.model.data?.length,
                    itemBuilder: (context, index) {
                      final item = state.model.data?[index];

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
                                Text(
                                  item?.addType ?? "",
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),

                                BlocListener<DeleteAddressCubit, DeleteAddressState>(
                                  listener: (context, state) {
                                    if (state is DeleteAddressErrorState) {
                                      AppToast.showError(context, "", state.error);
                                      return;
                                    }
                                    if (state is DeleteAddressLoadedState) {
                                      AppToast.showSuccess(context, "", "Delete Successfully");
                                      context.read<GetAllAddressCubit>().getAllAddress();
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_) => AddUpdateAddressScreen(item: item)),
                                          );
                                        },
                                        child: const Icon(Icons.edit, size: 20),
                                      ),
                                      SizedBox(height: 12),
                                      InkWell(
                                        onTap: () {
                                          _showDeleteConfirmDialog(context, item?.id.toString() ?? "");
                                        },
                                        child: const Icon(Icons.delete, size: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            Text(item?.fullName ?? "", style: const TextStyle(fontWeight: FontWeight.w600)),

                            const SizedBox(height: 4),

                            Text(item?.fullAddress ?? "", style: const TextStyle(color: Colors.black54, height: 1.4)),

                            const SizedBox(height: 6),

                            Text("Phone: ${item?.phoneNo ?? ""}", style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                      );
                    },
                  );
          }
          return SizedBox();
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal:14,vertical: 20),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
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

  Future<void> _showDeleteConfirmDialog(BuildContext context, String addressId) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Delete Address"),
          content: const Text("Are you sure you want to delete this address?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                context.read<DeleteAddressCubit>().deleteAdrress(addressId: addressId);
              },
              child: Text("Yes, Delete", style: TextStyle(color: AppColors.white)),
            ),
          ],
        );
      },
    );
  }
}
