import 'package:flutter/material.dart';
import 'package:zeggo_cus/features/auth/view/login_view.dart';
import 'package:zeggo_cus/utils/storage/storage.dart';

class AuthGuard {
  static bool isLoggedIn() {
    final userId = LocalStorageUtils.getUserId();
    return userId != null && userId.isNotEmpty;
  }

  static void checkLogin({required BuildContext context, required VoidCallback onLoggedIn}) {
    if (isLoggedIn()) {
      onLoggedIn();
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginView()));
    }
  }
}
