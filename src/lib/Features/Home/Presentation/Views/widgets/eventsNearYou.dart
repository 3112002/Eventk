import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/showLoginSheet.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_states.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/deleteInterest_cubit/deleteInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/addInterestCubit/addIniterestCubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/addInterestCubit/addInterestState.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/deleteIntCubit/delIniterestCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

/*Yara Adel Mohamed*/
class EventsNearYou extends StatefulWidget {
  EventsNearYou({super.key, required this.item});
  final Item item;

  @override
  State<EventsNearYou> createState() => _EventsNearYouState();
}

class _EventsNearYouState extends State<EventsNearYou> {
  bool isInt = false;

  @override
  Widget build(BuildContext context) {
    print(widget.item.eventId);
    return Padding(
      padding: EdgeInsets.only(left: 9.w, top: 5.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 250.h,
        ),
        child: Stack(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 320.w,
                  height: 250.h,
                ),
                Positioned(
                  bottom: 80.h,
                  left: 0.w,
                  child: Container(
                    height: 170.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.item!.eventPicture),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30.h,
                  child: Container(
                    width: 320.w,
                    height: 75.h,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.item!.eventName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Styles.styleText20,
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy – hh:mm a')
                              .format(widget.item!.startDate!),
                          style:
                              Styles.styleText15.copyWith(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
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
                    child: IconButton(
                        icon: widget.item.isInterested == true
                            ? Icon(Icons.star)
                            : Icon(Icons.star_border_outlined),
                        color: Colors.blue,
                        onPressed: () async {
                          if (widget.item.isInterested == false) {
                            BlocProvider.of<AddInitCubit>(context)
                                .AddInt(eventId: widget.item.eventId);
                            setState(() {
                              widget.item.isInterested = true;
                              isInt = true;
                            });
                          }
                          if (widget.item.isInterested == true &&
                              isInt == false) {
                            BlocProvider.of<DelInitCubit>(context)
                                .DelInt(eventId: widget.item.eventId);
                            setState(() {
                              widget.item.isInterested = false;
                            });
                          }
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
