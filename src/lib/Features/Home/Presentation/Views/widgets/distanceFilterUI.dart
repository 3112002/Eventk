import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DistanceFilterUI extends StatefulWidget {
  const DistanceFilterUI({super.key});

  @override
  State<DistanceFilterUI> createState() => _DistanceFilterUIState();
}

class _DistanceFilterUIState extends State<DistanceFilterUI> {
  Set<String> selectedDistance = {'5 kms'};

  void updateSelected(Set<String> selection) {
    setState(() {
      selectedDistance = selection;
      getIt<CacheHelper>().saveData(key: 'distance', value: selectedDistance);
      print(getIt<CacheHelper>().getData(key: 'distacne'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 30.h)),
        Text('Selected Distance', style: Styles.styleText20),
        Padding(padding: EdgeInsets.only(top: 50.h)),
        SegmentedButton(
          style: SegmentedButton.styleFrom(
            selectedBackgroundColor: Color(0xFFEDF4FD),
          ),
          segments: <ButtonSegment<String>>[
            ButtonSegment(
              value: '5 kms',
              label: Text(
                '5 km',
                style: Styles.styleText20,
              ),
            ),
            ButtonSegment(
              value: '10 kms',
              label: Text(
                '10 kms',
                style: Styles.styleText20,
              ),
            ),
            ButtonSegment(
              value: '20 kms',
              label: Text(
                '20 kms',
                style: Styles.styleText20,
              ),
            ),
            ButtonSegment(
              value: '50 kms',
              label: Text(
                '50 kms',
                style: Styles.styleText20,
              ),
            ),
          ],
          selected: selectedDistance,
          onSelectionChanged: updateSelected,
        )
      ],
    );
  }
}
