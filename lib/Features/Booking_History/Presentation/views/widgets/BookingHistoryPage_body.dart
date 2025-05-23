import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/BookingOrder_cubit/BookingOrder_cubit.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/BookingOrder_cubit/BookingOrder_states.dart';
import 'package:eventk/Features/Booking_History/Presentation/views/widgets/BookingCard.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookingorderCubit>().fetchBookingHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                AssestsImages.backgroundEvents,
                width: double.infinity,
                height: 100.h,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 65,
                left: 20,
                child: Text(
                  "Booking History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 5.r,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<BookingorderCubit, BookingorderStates>(
              listener: (context, state) {
                if (state is BookingFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: ${state.error}"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is BookingLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BookingSuccessState) {
                  if (state.orders.isEmpty) {
                    return Center(
                      child: Text(
                        "No bookings found.",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      final booking = state.orders[index];
                      return BookingCard(booking: booking);
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "Fetch your booking history.",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
