import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/selectDistance.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/turnOnLocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DistanceFilterUI extends StatefulWidget {
  const DistanceFilterUI({super.key, this.initialValue, this.onChanged});
  final double? initialValue;
  final ValueChanged<double>? onChanged;
  @override
  State<DistanceFilterUI> createState() => _DistanceFilterUIState();
}

class _DistanceFilterUIState extends State<DistanceFilterUI> {
  final address = getIt<CacheHelper>().getData(key: 'address');
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
        Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: address != null
              ? SelectDistanceWidget(
                  initailValue: widget.initialValue,
                  onChanged: widget.onChanged,
                )
              : TurnOnLocation(),
        ),
      ],
    );
  }
}
