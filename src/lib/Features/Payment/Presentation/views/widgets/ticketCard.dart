import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketCard extends StatelessWidget {
  final String ticketName;
  final double price;
  final int noOfAvailableTickets;
  final int selectedCount;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const TicketCard({
    super.key,
    required this.ticketName,
    required this.price,
    required this.noOfAvailableTickets,
    required this.selectedCount,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticketName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              letterSpacing: 1.3,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "$price | Available: $noOfAvailableTickets",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                color: Colors.redAccent,
                onPressed: selectedCount > 0 ? onRemove : null,
              ),
              Text(
                "$selectedCount",
                style: TextStyle(fontSize: 18.sp, color: Colors.grey),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                color: Colors.green,
                onPressed: selectedCount < noOfAvailableTickets ? onAdd : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
