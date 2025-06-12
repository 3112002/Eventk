import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:flutter/material.dart';

int selectedValue = 0;

/*Yara Adel Mohamed*/
class PriceFilterUI extends StatefulWidget {
  const PriceFilterUI({super.key});

  @override
  State<PriceFilterUI> createState() => _PriceFilterUIState();
}

class _PriceFilterUIState extends State<PriceFilterUI> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio(
              groupValue: selectedValue,
              value: 1,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                  getIt<CacheHelper>().saveData(key: 'isPaid', value: false);
                });
              },
            ),
            Text('Free Tickets', style: Styles.styleText20),
          ],
        ),
        Row(
          children: [
            Radio(
              groupValue: selectedValue,
              value: 2,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                  getIt<CacheHelper>().saveData(key: 'isPaid', value: true);
                });
              },
            ),
            Text('Paid Tickets', style: Styles.styleText20),
          ],
        ),
      ],
    );
  }
}
