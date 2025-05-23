import 'package:eventk/Features/Payment/Data/models/TicketTypeModel.dart';
import 'package:eventk/Features/Payment/Presentation/views/widgets/TotalPriceFunc.dart';
import 'package:eventk/Features/Payment/Presentation/views/widgets/phoneNumberButtomSheet.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectticketpageFooter extends StatelessWidget {
  final List<Tickettypemodel> tickets;
  final List<int> selectedCounts;
  final VoidCallback onProceed;
  const SelectticketpageFooter(
      {super.key,
      required this.tickets,
      required this.selectedCounts,
      required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Tickets: ${selectedCounts.fold(0, (sum, item) => sum + item)}",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      "Total Price: EGP ${calculateTotalPrice(tickets, selectedCounts).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 38.w),
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.r)),
                          ),
                          builder: (context) {
                            return Phonenumberbuttomsheet(
                              onPhoneNumberSubmitted: (phone) {},
                              tickets: tickets,
                              selectedCounts: selectedCounts,
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kButtonsColor,
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 20.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: Text(
                      "Proceed",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
