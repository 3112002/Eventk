import 'package:eventk/Features/Payment/Presentation/manager/findTicket_cubit/findTicket_cubit.dart';
import 'package:eventk/Features/Payment/Presentation/manager/findTicket_cubit/findTicket_states.dart';
import 'package:eventk/Features/Payment/Presentation/views/widgets/SelectTicketPage_Footer.dart';
import 'package:eventk/Features/Payment/Presentation/views/widgets/ticketCard.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketselectionpageBody extends StatefulWidget {
  final eventId;
  const TicketselectionpageBody({super.key, this.eventId});

  @override
  State<TicketselectionpageBody> createState() =>
      _TicketselectionpageBodyState();
}

class _TicketselectionpageBodyState extends State<TicketselectionpageBody> {
  List<int> selectedCounts = [];
  @override
  void initState() {
    super.initState();
    context.read<FindticketCubit>().getTicketsTypes(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kButtonsColor,
        elevation: 4,
        centerTitle: true,
        title: Text(
          "Select Tickets",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<FindticketCubit, FindticketStates>(
        listener: (context, state) {
          if (state is FindTicketErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is FindTicketLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FindTicketLoadedState) {
            final tickets = state.tickets;
            if (selectedCounts.isEmpty) {
              selectedCounts = List.filled(tickets.length, 0);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Available Tickets",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];

                      return TicketCard(
                        ticketName: ticket.ticketName,
                        price: ticket.price,
                        noOfAvailableTickets: ticket.availableTickets,
                        selectedCount: selectedCounts[index],
                        onAdd: () {
                          setState(() {
                            selectedCounts[index]++;
                          });
                        },
                        onRemove: () {
                          if (selectedCounts[index] > 0) {
                            setState(() {
                              selectedCounts[index]--;
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
                SelectticketpageFooter(
                  tickets: tickets,
                  selectedCounts: selectedCounts,
                  onProceed: () {},
                )
              ],
            );
          }
          return Center(
              child: Text(
            "No data yet",
            style: TextStyle(color: Colors.black),
          ));
        },
      ),
    );
  }
}
