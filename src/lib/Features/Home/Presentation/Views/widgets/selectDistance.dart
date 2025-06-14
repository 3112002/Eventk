import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SelectDistanceWidget extends StatefulWidget {
  const SelectDistanceWidget({super.key});

  @override
  State<SelectDistanceWidget> createState() => _SelectDistanceWidgetState();
}

class _SelectDistanceWidgetState extends State<SelectDistanceWidget> {
  double mvalue = 0.0;
  double mxValue = 1000.0;
  RangeValues values = RangeValues(0.0, 1000.0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 10.h)),
        Text('Selected Distance', style: Styles.styleText20),
        Padding(padding: EdgeInsets.only(top: 30.h)),
        SizedBox(
            width: double.infinity,
            child: SliderTheme(
              data: SliderThemeData(
                overlayColor: Colors.blue,
                valueIndicatorColor: Colors.blue,
                // activeLabelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                // inactiveLabelStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
              child: SfSlider(
                min: 0.0,
                max: 1000.0,
                activeColor: Colors.blue,
                value: mvalue,
                interval: 200,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    mvalue = value;
                    getIt<CacheHelper>().saveData(key: 'Radius', value: mvalue);
                  });
                },
              ),
            )),
      ],
    );
  }
}
