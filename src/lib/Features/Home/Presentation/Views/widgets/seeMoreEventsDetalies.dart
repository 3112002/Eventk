import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/showLoginSheet.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_states.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/deleteInterest_cubit/deleteInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/addInterestCubit/addIniterestCubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/deleteIntCubit/delIniterestCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/*Yara Adel Mohamed Elsayed❤️*/
class SeeMoreEventsDetalies extends StatefulWidget {
  const SeeMoreEventsDetalies({super.key, required this.item});
  final Item item;

  @override
  State<SeeMoreEventsDetalies> createState() => _SeeMoreEventsDetaliesState();
}

class _SeeMoreEventsDetaliesState extends State<SeeMoreEventsDetalies> {
  bool isInt = false;
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
                      widget.item.eventName,
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
                            .format(widget.item.startDate!),
                        style: Styles.styleText12.copyWith(color: Colors.blue),
                      ),
                      Positioned(
                        left: 265.w,
                        bottom: 90.h,
                        child: Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              icon: widget.item.isInterested == true
                                  ? Icon(Icons.star)
                                  : Icon(Icons.star_border_outlined),
                              color: Colors.blue,
                              onPressed: () async {
                                if (widget.item.isInterested == true) {
                                  BlocProvider.of<DelInitCubit>(context)
                                      .DelInt(eventId: widget.item.eventId);
                                  setState(() {
                                    widget.item.isInterested = false;
                                  });
                                } else {
                                  BlocProvider.of<AddInitCubit>(context)
                                      .AddInt(eventId: widget.item.eventId);
                                  setState(() {
                                    widget.item.isInterested = true;
                                  });
                                }
                              }),
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
