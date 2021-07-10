import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static const channelId = 'todo-channel-id';
  static const channelName = 'todo-channel-name';
  static const channelDesc = 'todo-channel-id';

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    print('Initialize notification service');

    final initSettingsAndroid = AndroidInitializationSettings('app_icon');

    final initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: null, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: selectNotification,
    );

    tz.initializeTimeZones();
  }

  Future selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  void showNotification(String id, String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
        id.hashCode,
        title,
        body,
        const NotificationDetails(
            android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDesc,
        )),
        payload: id);
  }

  void scheduleNotification(
    String id,
    String title,
    String body,
    DateTime taskDate,
  ) async {
    final difference = taskDate.difference(DateTime.now());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id.hashCode,
        title,
        body,
        tz.TZDateTime.now(tz.local)
            .add(difference)
            .subtract(Duration(minutes: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDesc,
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void cancelNotification(String id) async {
    await flutterLocalNotificationsPlugin.cancel(id.hashCode);
  }
}
