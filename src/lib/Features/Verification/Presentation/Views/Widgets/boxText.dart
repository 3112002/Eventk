import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Verification/Presentation/Views/Widgets/verificationTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Yara❤️*/

final focus1 = FocusNode();
final focus2 = FocusNode();
final focus3 = FocusNode();
final focus4 = FocusNode();
final focus5 = FocusNode();
final focus6 = FocusNode();
final controller1 = TextEditingController();
final controller2 = TextEditingController();
final controller3 = TextEditingController();
final controller4 = TextEditingController();
final controller5 = TextEditingController();
final controller6 = TextEditingController();
void saveOtp() {
  final otp = '${controller1.text}${controller2.text}${controller3.text}'
      '${controller4.text}${controller5.text}${controller6.text}';
  getIt<CacheHelper>().saveData(key: 'otp', value: otp);
}

class FittedBoxText extends StatelessWidget {
  const FittedBoxText({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 15.h)),
          VerificationTextfields(
              currentNode: focus1,
              nextNode: focus2,
              controller: controller1,
              previousNode: null),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
          ),
          VerificationTextfields(
              currentNode: focus2,
              nextNode: focus3,
              controller: controller2,
              previousNode: focus1),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
          ),
          VerificationTextfields(
              currentNode: focus3,
              nextNode: focus4,
              controller: controller3,
              previousNode: focus2),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
          ),
          VerificationTextfields(
              currentNode: focus4,
              nextNode: focus5,
              controller: controller4,
              previousNode: focus3),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
          ),
          VerificationTextfields(
              currentNode: focus5,
              nextNode: focus6,
              controller: controller5,
              previousNode: focus4),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
          ),
          VerificationTextfields(
              currentNode: focus6,
              nextNode: null,
              controller: controller6,
              previousNode: focus5),
          Padding(
            padding: EdgeInsets.only(right: 15.w),
          ),
        ],
      ),
    );
  }
}
