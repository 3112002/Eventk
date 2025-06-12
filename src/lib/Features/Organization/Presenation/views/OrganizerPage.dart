import 'package:eventk/Features/Organization/Presenation/views/widgets/OrganizerPage_body.dart';
import 'package:flutter/material.dart';

class OrganizerPage extends StatelessWidget {
  final int organizationId;
  const OrganizerPage({super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    return OrganizerpageBody(
      organizationId: organizationId,
    );
  }
}
