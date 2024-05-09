import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class GlobalVariables {
  static const cloudinaryName = "dkintlemd";
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance2_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true,
  );
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
}
