import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tugas_akhir_project/utils/constants/global_variables.dart';

class FirebaseHelper {
  static void initHelper() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //foreground handle
    FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);

    //background handle
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    show(
        title: message.notification?.title ?? "No Title",
        body: message.notification?.body ?? "No Body",
        data: Map<String, String>.from(message.data),
        channel: GlobalVariables.channel);
  }

  static Future<void> _firebaseMessagingForegroundHandler(
      RemoteMessage message) async {
    show(
        title: message.notification?.title ?? "No Title",
        body: message.notification?.body ?? "No Body",
        channel: GlobalVariables.channel,
        data: message.data.isNotEmpty
            ? Map<String, String>.from(message.data)
            : null);
  }

  static Future<void> show({
    required final String title,
    required final String body,
    final Map<String, String>? data,
    required final AndroidNotificationChannel channel,
  }) async {
    final AndroidNotificationDetails notificationAndroidSpecifics =
        AndroidNotificationDetails(
      channel.id,
      icon: "@mipmap/launcher_icon",
      channel.name,
      channelDescription: channel.description,
      importance: Importance.max,
      playSound: true,
    );

    final NotificationDetails notificationPlatformSpecifics =
        NotificationDetails(android: notificationAndroidSpecifics);
    await GlobalVariables.flutterLocalNotificationsPlugin
        .show(2, title, body, notificationPlatformSpecifics, payload: data != null ? jsonEncode(data) : null);
  }
}
