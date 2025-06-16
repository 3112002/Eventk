import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/priceRange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel Mohamed*/
class PriceFilterUI extends StatefulWidget {
  const PriceFilterUI({super.key, this.initialValue, this.onChanged});
  final bool? initialValue;
  final ValueChanged<bool>? onChanged;
  @override
  State<PriceFilterUI> createState() => _PriceFilterUIState();
}

class _PriceFilterUIState extends State<PriceFilterUI> {
  late bool? isPaid;
  @override
  void initState() {
    super.initState();
    isPaid = widget.initialValue ?? null;
  }

  void handleChange(bool? newValue) {
    setState(() {
      isPaid = newValue;
    });
    getIt<CacheHelper>().saveData(key: 'isPaid', value: isPaid);
    widget.onChanged?.call(isPaid!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<bool>(
              groupValue: isPaid,
              value: false,
              activeColor: Colors.blue,
              onChanged: handleChange,
            ),
            Text('Free Tickets', style: Styles.styleText20),
          ],
        ),
        Row(
          children: [
            Radio<bool>(
              groupValue: isPaid,
              value: true,
              activeColor: Colors.blue,
              onChanged: handleChange,
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
