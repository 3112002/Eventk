import 'package:eventk/Features/Home/Presentation/Views/notificationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

/*Yara Adel*/
class IconNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return EmptyNotificationsScreen();
            },
          ),
        );
      },
      icon: Icon(
        LineIcons.bell,
        size: 28.w,
        color: Colors.white,
      ),
    );
  }
}
