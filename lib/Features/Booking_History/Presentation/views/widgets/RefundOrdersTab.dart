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
          final refundedOrders =
              state.orders.where((order) => order.isRefunded == true).toList();

          if (refundedOrders.isEmpty) {
            return const Center(child: Text("No refunded orders yet."));
          }

          return ListView.builder(
            itemCount: refundedOrders.length,
            itemBuilder: (context, index) {
              final item = refundedOrders[index];
              return OrderCard(
                ticketTypeDetails: item.ticketTypeDetails,
                ticketTypeName: item.ticketTypeName,
                quantity: item.quantity,
                unitPrice: item.unitPrice,
                tickets: item.tickets
                    .map((t) => {
                          'code': t.code,
                          'status': t.status,
                        })
                    .toList(),
                isRefunded: item.isRefunded,
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
