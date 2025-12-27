import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:zeggo_cus/constants/app_messaging.dart';
import 'package:zeggo_cus/main.dart';

class AppInit {
  static Future<void> init() async {
    if (!kIsWeb) {
      AppMessaging.init();

      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      debugPrint("Permission Status: ${settings.authorizationStatus}");

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        firebasetoken = await FirebaseMessaging.instance.getToken();
        log("FCM Token: $firebasetoken");
      } else {
        debugPrint("User denied notification permission");
      }
      await FirebaseMessaging.instance.subscribeToTopic('all');
      await FirebaseMessaging.instance.subscribeToTopic(
        RegExp(r'^[a-zA-Z0-9-_.~%]{1,900}$').hasMatch("$firebasetoken").toString(),
      );
      FirebaseMessaging.instance.setAutoInitEnabled(true);

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
      firebasetoken = await FirebaseMessaging.instance.getToken();
      log("Token $firebasetoken");
    }
  }
}
