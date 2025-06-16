import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eventk/Core/utils/notificaion_service.dart';
import 'package:flutter/material.dart';

class Noti extends StatelessWidget {
  const Noti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextButton(
                onPressed: () async {
                  bool isAllowed =
                      await AwesomeNotifications().isNotificationAllowed();
                  print('Notification allowed: $isAllowed');

                  if (isAllowed) {
                    AwesomeNotifications().createNotification(
                        content: NotificationContent(
                      id: 0,
                      channelKey: 'basic key',
                      title: 'Hello Yoya',
                      body: 'Test',
                    ));
                  }
                },
                child: Text('Show Notif')),
          ],
        ));
  }
}
