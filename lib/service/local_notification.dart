import 'package:flutter/material.dart';
import 'package:flutter_local_notification/message.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../global_context.dart';

class LocalNotification {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('bell');

    notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
          debugPrint('notification payload: $payload');
        }
        if (payload == "message") {
          await Navigator.push(
            GlobalContextServive.navigatorKey.currentContext!,
            MaterialPageRoute(builder: (context) => MessageScreen()),
          );
        }
      },
      // onDidReceiveBackgroundNotificationResponse: (details) { },
    );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('alarm_clock'),
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction(
              'id_1',
              'Cancel',
              titleColor: Colors.red,
            ),
            AndroidNotificationAction('id_2', 'Type Here',
                inputs: [AndroidNotificationActionInput(label: "Type Here")]),
            AndroidNotificationAction('id_3', 'Open', showsUserInterface: true),
          ],
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 1, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin
        .show(id, title, body, await notificationDetails(), payload: payLoad);
  }

  Future cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }

  Future cancelAllNotification() async {
    await notificationsPlugin.cancelAll();
  }
}
