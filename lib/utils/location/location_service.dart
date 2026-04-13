import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zeggo_cus/widgets/location_permission_dialog.dart';

class LocationService {
  static Future<bool> ensureLocationEnabled(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      bool? result = await _showPermissionDialog(context);
      if (result == true) {
        await Geolocator.openLocationSettings();
      }
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      bool? result = await _showPermissionDialog(context);
      if (result == true) {
        permission = await Geolocator.requestPermission();
      } else {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool? result = await _showPermissionDialog(context);
      if (result == true) {
        await Geolocator.openAppSettings();
      }
      return false;
    }

    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  static Future<bool?> _showPermissionDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => LocationPermissionDialog(
        onEnablePressed: () {
          Navigator.pop(context, true);
        },
        onManualPressed: () {
          Navigator.pop(context, false);
        },
      ),
    );
  }
}
