//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// /*Yara Adel Mohamed*/
// class NotificationService {
//   final notificationsPlugin = FlutterLocalNotificationsPlugin();
//   bool isInitialized_ = false;
//   bool get isInitialized => isInitialized_;
//   Future<void> initNotifiaction() async {
//     if (isInitialized_) return;
//     const initSettingsAndroid =
//         AndroidInitializationSettings('src/assets/Images/logo_E.png');
//     const DarwinInitializationSettings initSettingsIos =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
//     const initSettings = InitializationSettings(
//       android: initSettingsAndroid,
//       iOS: initSettingsIos,
//     );
//     await notificationsPlugin.initialize(initSettings);
//     isInitialized_ = true;
//   }

//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'Yara',
//         'Yara',
//         channelDescription: 'Daily Notification channel',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//   }

//   Future<void> showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//   }) async {
//     return notificationsPlugin.show(id, title, body, NotificationDetails());
//   }
// }
