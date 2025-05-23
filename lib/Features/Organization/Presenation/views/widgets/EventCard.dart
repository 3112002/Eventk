import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/showLoginSheet.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/deleteInterest_cubit/deleteInterest_cubit.dart';
import 'package:eventk/Features/Organization/Data/models/getOrganizationEventsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';

class OrganizationEventsCard extends StatefulWidget {
  final Getorganizationeventsmodel event;

  OrganizationEventsCard({super.key, required this.event});

  @override
  State<OrganizationEventsCard> createState() => _OrganizationEventsCardState();
}

class _OrganizationEventsCardState extends State<OrganizationEventsCard> {
  late final Item item;
  late bool? isInterested;
  @override
  void initState() {
    super.initState();

    item = Item(
      eventId: widget.event.eventId,
      eventName: widget.event.eventName,
      startDate: DateTime.parse(widget.event.startDate),
      eventPicture: widget.event.eventPic,
      latitude: widget.event.latitude,
      longitude: widget.event.longitude,
      isInterested: false,
    );

    isInterested = item.isInterested;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Row(
        children: [
          Container(
            height: 120.h,
            width: 160.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              widget.event.eventPic,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AssestsImages.testImagePopluar,
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.event.eventName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Styles.styleText20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat('MMM dd, yyyy – hh:mm a')
                              .format(DateTime.parse(widget.event.startDate)),
                          style:
                              Styles.styleText12.copyWith(color: Colors.blue),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (isInterested == null) {
                            showLoginSheet(context);
                            return;
                          }

                          if (isInterested == true) {
                            await context
                                .read<DeleteinterestCubit>()
                                .deleteInterest(item.eventId);
                            setState(() {
                              isInterested = false;
                              item.isInterested = false;
                            });
                          } else {
                            await context
                                .read<AddinterestCubit>()
                                .addInterest(item.eventId);
                            setState(() {
                              isInterested = true;
                              item.isInterested = true;
                            });
                          }
                        },
                        icon: LineIcon.star(
                          color:
                              isInterested == true ? Colors.amber : Colors.grey,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
