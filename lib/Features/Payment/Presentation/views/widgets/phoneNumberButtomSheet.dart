import 'package:dio/dio.dart';
import 'package:eventk/Core/utils/PaymentIntent_service.dart';
import 'package:eventk/Features/Payment/Data/models/TicketTypeModel.dart';
import 'package:eventk/Features/Payment/Presentation/views/widgets/PaymentWebPageView.dart';
import 'package:eventk/Features/Payment/Presentation/views/widgets/PhoneNumberField.dart';
import 'package:eventk/Features/Payment/Presentation/views/widgets/ReturnPhoneNo.dart';
import 'package:eventk/Features/Payment/Presentation/views/widgets/phoneNoValidation.dart';
import 'package:eventk/constants.dart';
import 'package:eventk/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Phonenumberbuttomsheet extends StatefulWidget {
  final Function(String) onPhoneNumberSubmitted;
  final List<Tickettypemodel> tickets;
  final List<int> selectedCounts;

  const Phonenumberbuttomsheet(
      {super.key,
      required this.onPhoneNumberSubmitted,
      required this.tickets,
      required this.selectedCounts});

  @override
  State<Phonenumberbuttomsheet> createState() => _PhonenumberbuttomsheetState();
}

class _PhonenumberbuttomsheetState extends State<Phonenumberbuttomsheet> {
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isValid = false;
  void initState() {
    super.initState();
    phoneController.addListener(() {
      final currentValid =
          Phonenovalidation.isvalidNumber(phoneController.text);
      if (isValid != currentValid) {
        setState(() {
          isValid = currentValid;
        });
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Your Phone Number",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Phonenumberfield(
              phoneController: phoneController,
            ),
            SizedBox(height: 20.h),
            Center(
              child: ElevatedButton(
                onPressed: isValid
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          final phone =
                              formatPhoneNumberToLocal(phoneController.text);

                          final items = <Map<String, dynamic>>[];
                          for (int i = 0; i < widget.tickets.length; i++) {
                            if (widget.selectedCounts[i] > 0) {
                              items.add({
                                "ticketTypeId": widget.tickets[i].ticketTypeId,
                                "quantity": widget.selectedCounts[i],
                              });
                            }
                          }
                          if (items.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Please select at least one ticket.")),
                            );
                            return;
                          }
                          try {
                            final url =
                                await PaymentintentService(api: Api(dio: Dio()))
                                    .createPaymentIntent(
                                        items: items, phoneNumber: phone);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    Paymentwebpageview(paymentUrl: url),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${e.toString()}")),
                            );
                          }
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kButtonsColor,
                  padding:
                      EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
