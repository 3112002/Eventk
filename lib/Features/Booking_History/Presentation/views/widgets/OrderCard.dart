import 'package:eventk/Features/Booking_History/Presentation/views/widgets/generate_and_openPdf.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCard extends StatelessWidget {
  final String ticketTypeName;
  final String ticketTypeDetails;
  final int quantity;
  final double unitPrice;
  final List<Map<String, dynamic>> tickets;
  final VoidCallback? onRefundPressed;
  final bool isRefunded;
  final int orderIndex;

  const OrderCard({
    super.key,
    required this.ticketTypeName,
    required this.ticketTypeDetails,
    required this.quantity,
    required this.unitPrice,
    required this.tickets,
    this.onRefundPressed,
    required this.isRefunded,
    required this.orderIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ticketTypeName,
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
                color: kButtonsColor,
              ),
            ),
            if (ticketTypeDetails.isNotEmpty) ...[
              SizedBox(height: 6.h),
              Container(
  margin: EdgeInsets.only(top: 6.h),
  padding: EdgeInsets.all(10.r),
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(12.r),
    border: Border.all(color: Colors.grey.shade300),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(width: 8.w),
      Expanded(
        child: Text(
          ticketTypeDetails,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[800],
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      ),
    ],
  ),
),

            ],
            Divider(height: 28.h, thickness: 1, color: Colors.grey[200]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantity: $quantity',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.payment,
                        size: 20.sp, color: kButtonsColor),
                    SizedBox(width: 4.w),
                    Text(
                      '${unitPrice.toStringAsFixed(2)} EGP',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      ' / ticket',
                      style:
                          TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(tickets.length, (index) {
                return GestureDetector(
                  onTap: () async {
                    await generateAndOpenPdf(
                      ticketTypeName: ticketTypeName,
                      ticketTypeDetails: ticketTypeDetails,
                      quantity: quantity,
                      unitPrice: unitPrice,
                      tickets: [tickets[index]],
                      index: orderIndex + 1,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      "Ticket ${index + 1}",
                      style: TextStyle(
                        color: kButtonsColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(
              height: 20.h,
            ),
            if (!isRefunded)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRefundPressed,
                  label: Text(
                    "Refund",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButtonsColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
