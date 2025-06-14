import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Features/Booking_History/Data/models/BookingOrder_model.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Booking_History/Presentation/views/BookingStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookingCard extends StatelessWidget {
  final BookingorderModel booking;

  const BookingCard({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd, yyyy – hh:mm a')
        .format(DateTime.parse(booking.paidAt));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Bookingstatus(
              orderId: booking.orderId,
            ),
          ),
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 110.h,
          maxHeight: 110.h,
          minWidth: double.infinity,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 110.h,
                width: 160.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(
                    booking.eventPic,
                    height: 110.h,
                    width: 160.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print("Failed to load image: $error");
                      return Image.asset(
                        AssestsImages.backgroundEvents,
                        height: 110.h,
                        width: 160.w,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      booking.eventName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Styles.styleText20.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        shadows: [
                          Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 1,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 16.sp, color: Colors.blueAccent),
                        SizedBox(width: 6.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Paid At:',
                              style: Styles.styleText12.copyWith(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              formattedDate,
                              style: Styles.styleText12.copyWith(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.payment, size: 18.sp, color: Colors.green),
                        SizedBox(width: 6.w),
                        Text(
                          'Total: EGP ${booking.totalAmount}',
                          style: Styles.styleText14.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
