import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:to_do_riverpod/constants/firebase_consts.dart';

class LocalNotification {
  static Future initialize() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/launcher_icon');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification({
    var id = 0,
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Nirav 1',
      'My Channel',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var notification = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(0, title, body, notification);
  }
}

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationServices {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   final AndroidInitializationSettings androidInitializationSettings =
//       AndroidInitializationSettings('launcher_icon');

//   void initializationNotifications() async {
//     InitializationSettings initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void sendNotification(String title, String body) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'channelId',
//       'channelName',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await flutterLocalNotificationsPlugin.show(
//         0, title, body, notificationDetails);
//   }
// }
