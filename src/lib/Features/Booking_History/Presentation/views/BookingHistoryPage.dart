import 'package:eventk/Features/Booking_History/Data/repos/BookingOrderRepoImpl.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/BookingOrder_cubit/BookingOrder_cubit.dart';
import 'package:eventk/Features/Booking_History/Presentation/views/widgets/BookingHistoryPage_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bookinghistorypage extends StatelessWidget {
  const Bookinghistorypage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BookingorderCubit(
              bookingRepo: Bookingorderrepoimpl(),
            )..fetchBookingHistory(),
        child: BookingHistoryScreen());
  }
}
