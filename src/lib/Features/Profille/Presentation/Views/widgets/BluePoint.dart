
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16,color: kButtonsColor)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16,color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}