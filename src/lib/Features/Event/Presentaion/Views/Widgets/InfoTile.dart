import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';

class Infotile extends StatelessWidget {
  final IconData icon;
  final String title;

  const Infotile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: kButtonsColor,
      ),
      title: Text(title),
    );
  }
}
