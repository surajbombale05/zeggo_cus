import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';

class LocationPermissionDialog extends StatelessWidget {
  final VoidCallback onEnablePressed;
  final VoidCallback onManualPressed;

  const LocationPermissionDialog({
    super.key,
    required this.onEnablePressed,
    required this.onManualPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Custom Location Off Icon (Red with Slash)
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                   Icon(
                    Icons.location_on_outlined,
                    size: 60,
                    color: Colors.grey.shade400,
                  ),
                  Transform.rotate(
                    angle: -0.8,
                    child: Container(
                      width: 70,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                   Positioned(
                    bottom: 25,
                    right: 25,
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.red.shade400,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            const Text(
              "Location permission not enabled",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            
            Text(
              "Please enable location permission for a better delivery experience",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            
            // Enable Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onEnablePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Enable device location",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Manual Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: onManualPressed,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Select location manually",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
