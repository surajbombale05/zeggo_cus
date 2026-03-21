import 'package:flutter/material.dart';
import 'package:zeggo_cus/features/auth/view/login_view.dart';
import 'package:zeggo_cus/main.dart';
import 'package:zeggo_cus/utils/storage/storage.dart';

class AuthGuard {
  static Future<bool> isLoggedIn() async {
    if (userId != null && userId!.isNotEmpty) {
      return true;
    }

     final storedId = await LocalStorageUtils.getUserId();

    if (storedId != null && storedId.isNotEmpty) {
      userId = storedId;
      return true;
    }

    return false;
  }

  static Future<void> checkLogin({required BuildContext context, required VoidCallback onLoggedIn}) async {
    if (await isLoggedIn()) {
      onLoggedIn();
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginView()));
    }
  }
}
