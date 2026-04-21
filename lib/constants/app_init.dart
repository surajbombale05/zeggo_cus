import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:zeggo_cus/constants/app_messaging.dart';
import 'package:zeggo_cus/main.dart';

class AppInit {
  static Future<void> init() async {
    if (!kIsWeb) {
      AppMessaging.init();
      final messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      debugPrint("Permission Status: ${settings.authorizationStatus}");

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        firebasetoken = await messaging.getToken();
        log("FCM Token: $firebasetoken");

        if (Platform.isIOS) {
          String? apnsToken = await messaging.getAPNSToken();
          log("APNS Token: $apnsToken");
          if (apnsToken == null) {
            log("Warning: APNS Token is null. Ensure Push Notifications capability is enabled and certificates are correctly configured in Firebase Console.");
          }
        }
        
        if (firebasetoken != null && firebasetoken!.isNotEmpty) {
          await messaging.subscribeToTopic('all');
          // Optional: subscribe to a topic based on the token if it matches valid chars
          if (RegExp(r'^[a-zA-Z0-9-_.~%]{1,900}$').hasMatch(firebasetoken!)) {
            await messaging.subscribeToTopic(firebasetoken!);
          }
        }
      } else {
        debugPrint("User denied notification permission");
      }
      messaging.setAutoInitEnabled(true);

      FirebaseMessaging.onBackgroundMessage(AppMessaging.backgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          log('Message also contained a notification: ${message.notification}');
          AppMessaging.createNotification(
            message.notification!.title.toString(),
            message.notification!.body.toString(),
          );
        }
      });
      log("Token $firebasetoken");
    }
  }
}
