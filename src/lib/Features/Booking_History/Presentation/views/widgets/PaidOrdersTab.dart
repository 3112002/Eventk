import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/OrderItem_cubit/OrderItem_states.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/Refund_cubit/Refund_cubit.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/Refund_cubit/Refund_states.dart';
import 'package:eventk/Features/Booking_History/Presentation/views/widgets/OrderCard.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventk/Features/Booking_History/Presentation/manager/cubits/OrderItem_cubit/OrderItem_cubit.dart';

class PaidOrdersTab extends StatelessWidget {
  final int orderId;
  const PaidOrdersTab({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OrderitemCubit, OrderitemStates>(
          listener: (context, state) {
            if (state is OrderItemFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${state.error}")),
              );
            }
          },
        ),
        BlocListener<RefundCubit, RefundStates>(
          listener: (context, state) {
            if (state is RefundLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            } else if (state is RefundSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.grey,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  duration: const Duration(seconds: 3),
                  elevation: 6,
                ),
              );

              context.read<OrderitemCubit>().fetchOrderItems(state.orderId);
            } else if (state is RefundFailureState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Refund failed: ${state.error}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  duration: const Duration(seconds: 4),
                  elevation: 6,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<OrderitemCubit, OrderitemStates>(
        builder: (context, state) {
          if (state is OrderItemLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderItemSuccessState) {
           
            final List<Map<String, dynamic>> individualTickets = [];
            for (var item in state.orders) {
              if (!item.isRefunded) {
                for (var ticket in item.tickets) {
                  individualTickets.add({
                    "ticketTypeName": item.ticketTypeName,
                    "ticketTypeDetails": item.ticketTypeDetails,
                    "unitPrice": item.unitPrice,
                    "ticket": ticket,
                    "orderItemId": item.orderItemId,
                  });
                }
              }
            }

            if (individualTickets.isEmpty) {
              return const Center(child: Text("No paid tickets yet."));
            }
            return ListView.builder(
                itemCount: individualTickets.length,
                itemBuilder: (context, index) {
                  final ticketData = individualTickets[index];
                  final ticket = ticketData["ticket"];
                  return OrderCard(
                    ticketTypeName: ticketData["ticketTypeName"],
                    ticketTypeDetails: ticketData["ticketTypeDetails"],
                    quantity: 1,
                    unitPrice: ticketData["unitPrice"],
                    tickets: [
                      {'code': ticket.code, 'status': ticket.status}
                    ],
                    isRefunded: ticket.status == "refunded",
                    onRefundPressed: () {
                      final parentContext = context;

                      showDialog(
                        context: parentContext,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text(
                            'Confirm Refund',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Text(
                            'Refund this ticket of ${ticketData["ticketTypeName"]}?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                                final List<Map<String, dynamic>> itemsToRefund =
                                    [
                                  {
                                    "orderItemId": ticketData["orderItemId"],
                                    "quantity": 1, 
                                  },
                                ];
                                parentContext.read<RefundCubit>().requesrRefund(
                                      orderId,
                                      itemsToRefund,
                                    );
                              },
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kButtonsColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    orderIndex: index,
                  );
                });
          } else {
            return const Center(child: Text("No data."));
          }
        },
      ),
    );
  }
}
