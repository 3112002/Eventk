import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/priceRange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel Mohamed*/
class PriceFilterUI extends StatefulWidget {
  const PriceFilterUI({super.key, this.isPaid});
  final int? isPaid;
  @override
  State<PriceFilterUI> createState() => _PriceFilterUIState();
}

class _PriceFilterUIState extends State<PriceFilterUI> {
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio(
              groupValue: selectedValue,
              value: 1,
              activeColor: Colors.blue,
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
              activeColor: Colors.blue,
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
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: getIt<CacheHelper>().getData(key: 'isPaid') == true
              ? PriceRangeWidget()
              : Text(''),
        )
      ],
    );
  }
}
