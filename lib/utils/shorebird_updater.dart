import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class ShorebirdHelper {
  static final ShorebirdUpdater _updater = ShorebirdUpdater();

  static void checkForUpdate() {
    try {
      log("Checking for Shorebird updates...");
      
      if (!_updater.isAvailable) {
        log("Shorebird is not available (likely running in debug mode or not built via shorebird release).");
        return;
      }
      
      _updater.checkForUpdate().then((status) {
        switch (status) {
          case UpdateStatus.outdated:
            log("New Shorebird patch available. Downloading...");
            _updater.update().then((_) {
              log("Shorebird patch downloaded. Will be applied on next restart.");
              _showRestartPrompt();
            }).catchError((e) {
              log("Shorebird update download failed: $e");
            });
            break;
            
          case UpdateStatus.restartRequired:
            log("Shorebird patch already downloaded, waiting for app restart.");
            _showRestartPrompt();
            break;
            
          case UpdateStatus.upToDate:
            log("Shorebird app is up to date.");
            break;
            
          case UpdateStatus.unavailable:
            log("Shorebird updates are currently unavailable.");
            break;
        }
      }).catchError((e) {
        log("Shorebird update check failed: $e");
      });
    } catch (e) {
      log("Shorebird exception: $e");
    }
  }

  static void _showRestartPrompt() {
    Get.snackbar(
      'Update Ready',
      'A new update has been downloaded. Please restart the app to apply changes.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 10),
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
    );
  }
}
