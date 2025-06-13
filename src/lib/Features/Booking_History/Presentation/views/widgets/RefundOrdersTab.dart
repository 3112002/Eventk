import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/OrderItem_cubit/OrderItem_states.dart';
import 'package:eventk/Features/Booking_History/Presentation/views/widgets/OrderCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/OrderItem_cubit/OrderItem_cubit.dart';

class RefundedOrdersTab extends StatelessWidget {
  const RefundedOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderitemCubit, OrderitemStates>(
      listener: (context, state) {
        if (state is OrderItemFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.error}")),
          );
        }
      },
      builder: (context, state) {
        if (state is OrderItemLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderItemSuccessState) {
          final List<Map<String, dynamic>> refundedTickets = [];
          for (var item in state.orders) {
            for (var ticket in item.tickets) {
              if (ticket.status == "refunded") {
                refundedTickets.add({
                  "ticketTypeName": item.ticketTypeName,
                  "ticketTypeDetails": item.ticketTypeDetails,
                  "unitPrice": item.unitPrice,
                  "ticket": ticket,
                });
              }
            }
          }

          if (refundedTickets.isEmpty) {
            return const Center(child: Text("No refunded orders yet."));
          }

          return ListView.builder(
            itemCount: refundedTickets.length,
            itemBuilder: (context, index) {
              final data = refundedTickets[index];
              final ticket = data["ticket"];
              return OrderCard(
                ticketTypeDetails: data["ticketTypeDetails"],
                ticketTypeName: data["ticketTypeName"],
                quantity: 1,
                unitPrice: data["unitPrice"],
                tickets: [
                  {
                    'code': ticket.code,
                    'status': ticket.status,
                  }
                ],
                isRefunded: true,
                orderIndex: index,
              );
            },
          );
        } else {
          return const Center(child: Text("No data."));
        }
      },
    );
  }
}
