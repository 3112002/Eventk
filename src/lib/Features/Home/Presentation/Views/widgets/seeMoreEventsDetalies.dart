import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/showLoginSheet.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_states.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/deleteInterest_cubit/deleteInterest_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';

/*Yara Adel❤️*/
class SeeMoreEventsDetalies extends StatefulWidget {
  const SeeMoreEventsDetalies({super.key, required this.item});
  final Item item;

  @override
  State<SeeMoreEventsDetalies> createState() => _SeeMoreEventsDetaliesState();
}

class _SeeMoreEventsDetaliesState extends State<SeeMoreEventsDetalies> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 120.h,
          maxHeight: 120.h,
          minWidth: 120.w,
          maxWidth: 120.w,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 120.h,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 120.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.item!.eventPicture),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 20.h)),
                Align(
                  alignment: Alignment.topLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.5,
                    ),
                    child: Text(
                      widget.item!.eventName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Styles.styleText20,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.h)),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy – hh:mm a')
                            .format(widget.item!.startDate!),
                        style: Styles.styleText12.copyWith(color: Colors.blue),
                      ),
                      // IconButton(onPressed: () {}, icon: LineIcon.star()),
                      Positioned(
                        left: 265.w,
                        bottom: 90.h,
                        child: Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(174, 255, 255, 255),
                          ),
                          child:
                              BlocConsumer<AddinterestCubit, AddinterestStates>(
                            listener: (context, state) {
                              if (state is AddInterestSuccessState) {
                              } else if (state
                                  is AddInterestUnAuthorizedState) {
                                showLoginSheet(context);
                              } else if (state is AddInterestErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.errorMessage)),
                                );
                              }
                            },
                            builder: (context, state) {
                              bool? isInterested = widget.item.isInterested;

                              return IconButton(
                                icon: LineIcon.star(
                                  size: 20.w,
                                  color: isInterested == true
                                      ? Color(0xFFFFD700)
                                      : Colors.blue,
                                ),
                                onPressed: () async {
                                  if (isInterested == null) {
                                    showLoginSheet(context);
                                    return;
                                  }

                                  if (isInterested) {
                                    await context
                                        .read<DeleteinterestCubit>()
                                        .deleteInterest(widget.item.eventId);
                                    setState(() {
                                      widget.item.isInterested = false;
                                    });
                                  } else {
                                    await context
                                        .read<AddinterestCubit>()
                                        .addInterest(widget.item.eventId);
                                    setState(() {
                                      widget.item.isInterested = true;
                                    });
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
