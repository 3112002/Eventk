import 'package:eventk/Core/utils/assests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizationHeader extends StatelessWidget {
  final String? logoUrl;

  const OrganizationHeader({
    super.key,
    required this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: Stack(
        children: [
          Image.asset(
            AssestsImages.backgroundEvents,
            width: double.infinity,
            height: 100.h,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 60.h,
            left: 20.w,
            child: CircleAvatar(
              radius: 60.r,
              backgroundImage: logoUrl != null && logoUrl!.isNotEmpty
                  ? NetworkImage(logoUrl!)
                  : AssetImage(AssestsImages.profileAvatar) as ImageProvider,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
