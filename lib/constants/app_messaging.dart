import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AppMessaging {
  String id = DateTime.now().microsecondsSinceEpoch.toString();
  static void init() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: "Hi",
        playSound: true,
        channelShowBadge: true,
        enableVibration: true,
        importance: NotificationImportance.High,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
    ]);
  }

  static Future<void> createNotification(String title, String body) async {
    var timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
        displayOnBackground: true,
        displayOnForeground: true,
      ),
      schedule: NotificationInterval(timeZone: timeZone, interval: const Duration(seconds: 5)),
    );
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint("Background Remote Message:${message.data}");
    if (message.notification != null) {
      AppMessaging.init();
      AppMessaging.createNotification(
        message.notification!.title ?? "New Notification",
        message.notification!.body ?? "",
      );
    }
  }
}
