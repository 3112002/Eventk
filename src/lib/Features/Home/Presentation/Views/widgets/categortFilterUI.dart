import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';

int selectedValue = 0;

/*Yara Adel Mohamed*/
class CategoryFilterUI extends StatefulWidget {
  const CategoryFilterUI({super.key, this.initialValue, this.onChanged});
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  @override
  State<CategoryFilterUI> createState() => _CategoryFilterUIState();
}

class _CategoryFilterUIState extends State<CategoryFilterUI> {
  late String? groupValue;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      groupValue = widget.initialValue;
    }
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
        buildRadio(17, 'Music'),
        buildRadio(18, 'Technology'),
        buildRadio(19, 'Business'),
        buildRadio(20, 'Sports'),
        buildRadio(21, 'Education'),
        buildRadio(22, 'Food & Drink '),
        buildRadio(23, 'Arts & Culture'),
        buildRadio(24, 'Health & Wellness'),
      ],
    );
  }

  Widget buildRadio(int value, String label) {
    return Row(
      children: [
        Radio(
          groupValue: selectedValue,
          value: value,
          activeColor: Colors.blue,
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue!;
              getIt<CacheHelper>().saveData(key: "categoryId", value: value);
            });
          },
        ),
        Text(
          label,
          style: Styles.styleText20,
        ),
      ],
    );
  }
}
