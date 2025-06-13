import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';

class OrganizationDetalies extends StatelessWidget {
  const OrganizationDetalies({super.key});
  static String id = 'OrganizationDetalies';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        'Helllooooo Yoya ',
        style: Styles.headingText40,
      ),
    );
  }
}
