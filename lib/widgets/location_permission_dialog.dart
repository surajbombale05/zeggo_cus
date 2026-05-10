import 'package:flutter/material.dart';
import 'package:zeggo_cus/constants/app_colors.dart';

class LocationPermissionDialog extends StatelessWidget {
  final VoidCallback onContinuePressed;
  final VoidCallback onManualPressed;

  const LocationPermissionDialog({
    super.key,
    required this.onContinuePressed,
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
            // Icon
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on_outlined,
                size: 60,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Location Access Needed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "We use your location to automatically detect your current address and show nearby delivery options.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 28),

            // ✅ SAFE BUTTON TEXT
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onContinuePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Manual option (VERY IMPORTANT for Apple)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: onManualPressed,
                child: const Text(
                  "Enter address manually",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
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