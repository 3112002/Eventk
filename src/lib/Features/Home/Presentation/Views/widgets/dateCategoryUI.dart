import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';

/*Yara Adel Mohamed*/
int value = 0;

class DateFilterUI extends StatefulWidget {
  const DateFilterUI({super.key, this.initialValue, this.onChanged});
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  @override
  State<DateFilterUI> createState() => _DateFilterUIState();
}

class _DateFilterUIState extends State<DateFilterUI> {
  late String? groupValue;

  @override
  void initState() {
    super.initState();
    // Initialize from widget property
    groupValue = widget.initialValue;
  }

  void onChanged(String? newValue) {
    if (newValue == null) return;
    setState(() {
      groupValue = newValue;
      // getIt<CacheHelper>().saveData(key: 'selectedDate', value: groupValue);
    });
    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Row(
          children: [
            Radio<String>(
                groupValue: groupValue,
                value: 'This weekend',
                activeColor: Colors.blue,
                onChanged: onChanged),
            Text(
              "This weekend",
              style: Styles.styleText20,
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              groupValue: groupValue,
              activeColor: Colors.blue,
              value: "This week",
              onChanged: onChanged,
            ),
            Text(
              "This week",
              style: Styles.styleText20,
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              groupValue: groupValue,
              activeColor: Colors.blue,
              value: "Next week",
              onChanged: onChanged,
            ),
            Text(
              "Next week",
              style: Styles.styleText20,
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              groupValue: groupValue,
              activeColor: Colors.blue,
              value: "To day",
              onChanged: onChanged,
            ),
            Text(
              "To day",
              style: Styles.styleText20,
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              groupValue: groupValue,
              value: "This month",
              activeColor: Colors.blue,
              onChanged: onChanged,
            ),
            Text(
              "This month",
              style: Styles.styleText20,
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              groupValue: groupValue,
              value: "Tomorrow",
              activeColor: Colors.blue,
              onChanged: onChanged,
            ),
            Text(
              "Tomorrow",
              style: Styles.styleText20,
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              groupValue: groupValue,
              value: 'This year',
              activeColor: Colors.blue,
              onChanged: onChanged,
            ),
            Text(
              "This year",
              style: Styles.styleText20,
            ),
          ],
        ),
      ],
    );
  }
}
