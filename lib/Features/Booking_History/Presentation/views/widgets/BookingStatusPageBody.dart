import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/OrderItem_cubit/OrderItem_cubit.dart';
import 'package:eventk/Features/Booking_History/Presentation/views/widgets/PaidOrdersTab.dart';
import 'package:eventk/Features/Booking_History/Presentation/views/widgets/RefundOrdersTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingStatusPageBody extends StatefulWidget {
  final int orderId;
  const BookingStatusPageBody({Key? key, required this.orderId})
      : super(key: key);

  @override
  State<BookingStatusPageBody> createState() => _BookingStatusPageBodyState();
}

class _BookingStatusPageBodyState extends State<BookingStatusPageBody>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderitemCubit>().fetchOrderItems(widget.orderId);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                left: 20.w,
                child: Text(
                  "Booking History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: const Offset(1, 1),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.blueAccent,
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Paid"),
                Tab(text: "Refund"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                PaidOrdersTab(
                  orderId: widget.orderId,
                ),
                RefundedOrdersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
