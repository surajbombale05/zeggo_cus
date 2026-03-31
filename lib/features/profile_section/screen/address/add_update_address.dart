import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:zeggo_cus/utils/location/location_service.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/constants/app_toast.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/get_all_address/get_all_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/get_all_address/get_all_address_model.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/post_address/post_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/update_address/update_address_cubit.dart';
import 'package:zeggo_cus/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zeggo_cus/features/profile_section/screen/address/map_picker_screen.dart';
import 'package:zeggo_cus/widgets/custom_svg.dart';

enum AddressType { home, work, other }

extension AddressTypeExt on AddressType {
  String get apiValue {
    switch (this) {
      case AddressType.home:
        return 'home';
      case AddressType.work:
        return 'work';
      case AddressType.other:
        return 'other';
    }
  }

  // String get label {
  //   switch (this) {
  //     case AddressType.home:
  //       return 'Home';
  //     case AddressType.work:
  //       return 'Work';
  //     case AddressType.other:
  //       return 'Other';
  //   }
  // }
}

class AddUpdateAddressScreen extends StatefulWidget {
  final Datum? item;

  const AddUpdateAddressScreen({super.key, this.item});

  @override
  State<AddUpdateAddressScreen> createState() => _AddUpdateAddressScreenState();
}

class _AddUpdateAddressScreenState extends State<AddUpdateAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  AddressType selectedAdd = AddressType.home;
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pin = TextEditingController();
  bool isPrimary = false;
  double? lat;
  double? lng;
  bool isFetchingLocation = false;

  // Track programmatically filled text to prevent clearing lat/lng
  String _lastFilledAddress = "";
  String _lastFilledCity = "";
  String _lastFilledPin = "";

  Future<void> _getCurrentLocation() async {
    setState(() => isFetchingLocation = true);
    try {
      bool hasPermission = await LocationService.ensureLocationEnabled();
      if (!hasPermission) {
        AppToast.showError(context, "Permission Denied", "Please enable location services and grant permission.");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      lat = position.latitude;
      lng = position.longitude;
      await _fillAddressFromLatLng(lat!, lng!);

      AppToast.showSuccess(context, "Location Found", "Captured exact location.");
    } catch (e) {
      print("Location Error: $e");
      AppToast.showError(context, "Error", "Failed to get current location: $e");
    } finally {
      setState(() => isFetchingLocation = false);
    }
  }

  Future<void> _fillAddressFromLatLng(double lat, double lng) async {
    try {
      final url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyCTxftYRjCP8PR_EKJGxLBUrr682DjaWOA";

      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);

      if (data['status'] == "OK") {
        Map<String, dynamic>? result;

        for (var r in data['results']) {
          List types = r['types'];

          if (!types.contains('plus_code') &&
              (types.contains('street_address') ||
                  types.contains('premise') ||
                  types.contains('route') ||
                  types.contains('sublocality') ||
                  types.contains('locality'))) {
            result = r;
            break;
          }
        }

        result ??= data['results'].first;

        String fullAddress = result?['formatted_address'];

        fullAddress = fullAddress.replaceAll(RegExp(r'^[A-Z0-9]+\+[A-Z0-9]+,\s*'), '');

        String cityName = "";
        String postalCode = "";

        for (var comp in result?['address_components']) {
          if (comp['types'].contains('locality')) {
            cityName = comp['long_name'];
          }
          if (comp['types'].contains('postal_code')) {
            postalCode = comp['long_name'];
          }
        }

        setState(() {
          address.text = fullAddress;
          city.text = cityName;
          pin.text = postalCode;

          _lastFilledAddress = fullAddress;
          _lastFilledCity = cityName;
          _lastFilledPin = postalCode;
        });
      } else {
        _fallbackLatLng(LatLng(lat, lng));
      }
    } catch (e) {
      _fallbackLatLng(LatLng(lat, lng));
    }
  }

  void _fallbackLatLng(LatLng position) {
    setState(() {});
  }

  Future<void> _openMapPicker() async {
    double startLat = lat ?? 20.5937;
    double startLng = lng ?? 78.9629;

    if (lat == null && address.text.isNotEmpty) {
      try {
        List<Location> locs = await locationFromAddress("${address.text}, ${city.text}, ${pin.text}");
        if (locs.isNotEmpty) {
          startLat = locs.first.latitude;
          startLng = locs.first.longitude;
        }
      } catch (_) {}
    }

    final LatLng? picked = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (_) => MapPickerScreen(initialLat: startLat, initialLng: startLng),
      ),
    );

    if (picked != null) {
      setState(() {
        lat = picked.latitude;
        lng = picked.longitude;
      });
      await _fillAddressFromLatLng(lat!, lng!);

      AppToast.showSuccess(context, "Location Confirmed", "Exact pin location saved.");
    }
  }

  Future<bool> getLatLngFromAddress() async {
    setState(() => isFetchingLocation = true);

    try {
      List<Location> locations = await locationFromAddress("${address.text}, ${city.text}, ${pin.text}");

      if (locations.isNotEmpty) {
        lat = locations.first.latitude;
        lng = locations.first.longitude;

        print("LAT: $lat, LNG: $lng");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Geocoding Error: $e");
      return false;
    } finally {
      setState(() => isFetchingLocation = false);
    }
  }

  @override
  void initState() {
    if (widget.item != null) {
      name.text = widget.item?.fullName ?? "";
      phone.text = widget.item?.phoneNo ?? "";
      address.text = widget.item?.fullAddress ?? "";
      city.text = widget.item?.city ?? "";
      pin.text = widget.item?.zipCode ?? "";
      isPrimary = widget.item?.isPrimary ?? false;
      switch (widget.item?.addType) {
        case 'home':
          selectedAdd = AddressType.home;
          break;
        case 'work':
          selectedAdd = AddressType.work;
          break;
        case 'other':
          selectedAdd = AddressType.other;
          break;
      }
      if (widget.item != null) {
        lat = double.tryParse(widget.item?.lat ?? "");
        lng = double.tryParse(widget.item?.long ?? "");
        _lastFilledAddress = address.text;
        _lastFilledCity = city.text;
        _lastFilledPin = pin.text;
      }

      address.addListener(() {
        if (address.text != _lastFilledAddress && mounted) {
          setState(() {
            lat = null;
            lng = null;
          });
        }
      });
      city.addListener(() {
        if (city.text != _lastFilledCity && mounted) {
          setState(() {
            lat = null;
            lng = null;
          });
        }
      });
      pin.addListener(() {
        if (pin.text != _lastFilledPin && mounted) {
          setState(() {
            lat = null;
            lng = null;
          });
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item != null ? "Edit Address" : "Add Address"),
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
                        setState(() => selectedAdd = AddressType.home);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedAdd == AddressType.home
                              ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
                              : AppColors.kGreyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedAdd == AddressType.home
                                ? Theme.of(context).primaryColor
                                : AppColors.kGreyColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            CustomSvgImage(
                              imageUrl: "assets/svg/home.svg",
                              color: selectedAdd == AddressType.home
                                  ? AppColors.primaryColor
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Home",
                              style: TextStyle(
                                color: selectedAdd == AddressType.home
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
                        setState(() => selectedAdd = AddressType.work);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedAdd == AddressType.work
                              ? AppColors.primaryColor.withValues(alpha: 0.15)
                              : AppColors.kGreyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedAdd == AddressType.work ? AppColors.primaryColor : AppColors.kGreyColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            CustomSvgImage(
                              imageUrl: "assets/svg/work.svg",
                              color: selectedAdd == AddressType.work
                                  ? AppColors.primaryColor
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Work",
                              style: TextStyle(
                                color: selectedAdd == AddressType.work
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
                        setState(() => selectedAdd = AddressType.other);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedAdd == AddressType.other
                              ? AppColors.primaryColor.withValues(alpha: 0.15)
                              : AppColors.kGreyColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedAdd == AddressType.other ? AppColors.primaryColor : AppColors.kGreyColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            CustomSvgImage(
                              imageUrl: "assets/svg/location.svg",
                              color: selectedAdd == AddressType.other
                                  ? AppColors.primaryColor
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Other",
                              style: TextStyle(
                                color: selectedAdd == AddressType.other
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
              if (isFetchingLocation)
                const Center(child: CircularProgressIndicator())
              else
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: _getCurrentLocation,
                        icon: Icon(Icons.my_location, color: AppColors.primaryColor),
                        label: Text("My Location", style: TextStyle(color: AppColors.primaryColor)),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: _openMapPicker,
                        icon: Icon(Icons.map_outlined, color: AppColors.primaryColor),
                        label: Text("Pick on Map", style: TextStyle(color: AppColors.primaryColor)),
                      ),
                    ),
                  ],
                ),
              if (lat != null && lng != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        "Location set: ${lat!.toStringAsFixed(5)}, ${lng!.toStringAsFixed(5)}",
                        style: const TextStyle(fontSize: 12, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 10),
              _inputField("Full Name", name),
              _inputField("Phone Number", phone, keyboardType: TextInputType.phone),
              _inputField("Full Address", address, maxLines: 3),
              _inputField("City", city),
              _inputField("Pincode", pin, keyboardType: TextInputType.number),
              SizedBox(height: 5),
              Text("Default"),
              SizedBox(height: 15),
              Switch(
                value: isPrimary,
                onChanged: (value) {
                  setState(() {
                    isPrimary = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              BlocConsumer<PostAddressCubit, PostAddressState>(
                listener: (context, state) {
                  if (state is PostAddressErrorState) {
                    AppToast.showError(context, "", state.error);
                    return;
                  }
                  if (state is PostAddressLoadedState) {
                    AppToast.showSuccess(context, "", "Create Succesfully");
                    context.read<GetAllAddressCubit>().getAllAddress();
                    Navigator.pop(context);
                  }
                },
                builder: (context, addState) {
                  return BlocConsumer<UpdateAddressCubit, UpdateAddressState>(
                    listener: (context, state) {
                      if (state is UpdateAddressErrorState) {
                        AppToast.showError(context, "", state.error);
                        return;
                      }
                      if (state is UpdateAddressLoadedState) {
                        AppToast.showSuccess(context, "", "Update Sucessfully");
                        context.read<GetAllAddressCubit>().getAllAddress();
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, updateState) {
                      return ((updateState is UpdateAddressLoadingState) || (addState is PostAddressLoadingState))
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (lat == null || lng == null) {
                                      bool success = await getLatLngFromAddress();
                                      if (!success || lat == null || lng == null) {
                                        AppToast.showError(context, "Invalid address", "Please enter a valid address");
                                        return;
                                      }
                                    }
                                    if (widget.item != null) {
                                      context.read<UpdateAddressCubit>().updateAdrress(
                                        addressId: widget.item?.id ?? "",
                                        addType: selectedAdd.apiValue,
                                        city: city.text,
                                        fullAddress: address.text,
                                        fullName: name.text,
                                        phoneNo: phone.text,
                                        userId: userId,
                                        isPrimary: isPrimary,
                                        zipCode: pin.text,
                                        lat: lat?.toString() ?? "",
                                        long: lng?.toString() ?? "",
                                      );
                                    } else {
                                      context.read<PostAddressCubit>().postAdrress(
                                        addType: selectedAdd.apiValue,
                                        city: city.text,
                                        fullAddress: address.text,
                                        fullName: name.text,
                                        phoneNo: phone.text,
                                        userId: userId ?? "",
                                        isPrimary: isPrimary,
                                        zipCode: pin.text,
                                        lat: lat?.toString() ?? "",
                                        long: lng?.toString() ?? "",
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  widget.item != null ? "Update Address" : "Save Address",
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                    },
                  );
                },
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
