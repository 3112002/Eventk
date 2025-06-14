import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListtile extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const ProfileListtile(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  State<ProfileListtile> createState() => _ProfileListtileState();
}

class _ProfileListtileState extends State<ProfileListtile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 9.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.w,
        ),
      ),
      child: ListTile(
        leading: Icon(widget.icon),
        title: Text(
          widget.text,
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: widget.onTap,
      ),
    );
  }
}
