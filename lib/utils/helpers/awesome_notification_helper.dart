import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tugas_akhir_project/utils/constants/global_variables.dart';

class LocalNotificationHelper {
  LocalNotificationHelper._();

  static void initHelper() async {
    await GlobalVariables.flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/launcher_icon")),
    );

    final platform = GlobalVariables.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(GlobalVariables.channel);
  }
}
