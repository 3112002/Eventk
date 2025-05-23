import 'package:eventk/Core/utils/assests.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssestsImages.backgroundEvents),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
