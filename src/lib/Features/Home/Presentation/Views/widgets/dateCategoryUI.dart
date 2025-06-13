import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';

/*Yara Adel Mohamed*/

class DateFilterUI extends StatefulWidget {
  const DateFilterUI({super.key, this.initialValue, this.onChanged});
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  @override
  State<DateFilterUI> createState() => _DateFilterUIState();
}

class _DateFilterUIState extends State<DateFilterUI> {
  late String? groupValue;

  final List<String> dateOptions = [
    "Today",
    "Tomorrow",
    "This week",
    "This weekend",
    "Next week",
    "This month",
    "This year",
  ];

  @override
  void initState() {
    super.initState();
    groupValue = widget.initialValue;
  }

  void onChanged(String? newValue) {
    if (newValue == null) return;
    setState(() {
      groupValue = newValue;
    });
    widget.onChanged?.call(newValue);
    getIt<CacheHelper>().saveData(key: 'selectedDate', value: newValue);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: dateOptions.length,
      itemBuilder: (BuildContext context, int index) {
        return buildRadio(dateOptions[index]);
      },
    );
  }

  Widget buildRadio(String value) {
    return Row(
      children: [
        Radio<String>(
          groupValue: groupValue,
          value: value,
          activeColor: Colors.blue,
          onChanged: onChanged,
        ),
        Text(
          value,
          style: Styles.styleText20,
        ),
      ],
    );
  }
}
