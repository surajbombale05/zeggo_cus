import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:zeggo_cus/constants/app_colors.dart';

class MapPickerScreen extends StatefulWidget {
  final double initialLat;
  final double initialLng;

  const MapPickerScreen({super.key, required this.initialLat, required this.initialLng});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late LatLng _pickedLocation;
  String _resolvedAddress = "Drag the pin to your exact location";
  bool _isResolving = false;
  Marker? _marker;
  @override
  void initState() {
    super.initState();
    _pickedLocation = LatLng(widget.initialLat, widget.initialLng);

    _marker = Marker(
      markerId: const MarkerId("picked"),
      position: _pickedLocation,
      draggable: true,
      onDragEnd: (newPosition) {
        setState(() {
          _pickedLocation = newPosition;
        });
        _resolveAddress(newPosition);
      },
    );

    _resolveAddress(_pickedLocation);
  }

  // Future<void> _decodePlusCodeAndSetAddress(String plusCode, LatLng position) async {
  //   try {
  //     final url =
  //         "https://maps.googleapis.com/maps/api/geocode/json?address=$plusCode,Mumbai&key=AIzaSyA7M-sl_SgQF6xBJkglQs2K5uNdM0pxips";

  //     final response = await http.get(Uri.parse(url));
  //     log("---- $response");
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);

  //       if (data['results'].isNotEmpty) {
  //         final result = data['results'][0];

  //         String address = result['formatted_address'];

  //         setState(() {
  //           _resolvedAddress = address;
  //         });
  //       } else {
  //         _fallbackLatLng(position);
  //       }
  //     } else {
  //       _fallbackLatLng(position);
  //     }
  //   } catch (e) {
  //     _fallbackLatLng(position);
  //   }
  // }

  void _fallbackLatLng(LatLng position) {
    setState(() {
      _resolvedAddress = "Lat: ${position.latitude.toStringAsFixed(5)}, Lng: ${position.longitude.toStringAsFixed(5)}";
    });
  }

  Future<void> _resolveAddress(LatLng position) async {
    setState(() => _isResolving = true);

    try {
      final url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyCTxftYRjCP8PR_EKJGxLBUrr682DjaWOA";

      final response = await http.get(Uri.parse(url));
      log("------ ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['results'].isNotEmpty) {
          final result = data['results'][0];

          setState(() {
            _resolvedAddress = result['formatted_address'];
          });
        } else {
          _fallbackLatLng(position);
        }
      } else {
        _fallbackLatLng(position);
      }
    } catch (e) {
      _fallbackLatLng(position);
    } finally {
      setState(() => _isResolving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Location"),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, _pickedLocation),
            child: const Text("Confirm", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _pickedLocation, zoom: 17),
            onMapCreated: (_) {},
            onCameraMove: (position) {
              _pickedLocation = position.target;
            },
            markers: _marker != null ? {_marker!} : {},
            onCameraIdle: () {
              setState(() {
                _marker = _marker!.copyWith(positionParam: _pickedLocation);
              });

              _resolveAddress(_pickedLocation);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: _isResolving
                  ? const Center(
                      child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.red, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _resolvedAddress,
                                style: const TextStyle(fontSize: 13),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                            onPressed: () => Navigator.pop(context, _pickedLocation),
                            child: const Text(
                              "Confirm This Location",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
