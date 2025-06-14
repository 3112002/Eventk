import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:flutter/material.dart';

class PriceRangeWidget extends StatefulWidget {
  const PriceRangeWidget({super.key});

  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
  double mnValue = 0.0;
  double mxValue = 10000.0;
  int i = 0;
  RangeValues values = RangeValues(0.0, 1000.0);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RangeSlider(
          divisions: 200,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          min: mnValue,
          max: mxValue,
          labels: RangeLabels(values.start.toString(), values.end.toString()),
          values: values,
          onChanged: (value) {
            setState(() {
              values = value;
              getIt<CacheHelper>()
                  .saveData(key: 'minPrice', value: values.start);

              getIt<CacheHelper>().saveData(key: 'maxPrice', value: values.end);
              print(values.start);
            });
          }),
    );
  }
}
