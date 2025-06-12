import 'package:eventk/Features/Booking_History/Data/repos/BookingOrderRepoImpl.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/OrderItem_cubit/OrderItem_cubit.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/Refund_cubit/Refund_cubit.dart';
import 'package:eventk/Features/Booking_History/Presentation/views/widgets/BookingStatusPageBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bookingstatus extends StatelessWidget {
  final int orderId;
  const Bookingstatus({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => OrderitemCubit(Bookingorderrepoimpl())
              ..fetchOrderItems(orderId),
          ),
          BlocProvider(
            create: (_) => RefundCubit(Bookingorderrepoimpl()),
          ),
        ],
        child: BookingStatusPageBody(
          orderId: orderId,
        ));
  }
}
