import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Core/utils/interset_model/interset_model.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Foryou/Data/Model/for_you_model/recommended_event.dart';
import 'package:eventk/Features/Intersted/Data/models/getInterest_model.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_states.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/deleteInterest_cubit/deleteInterest_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class ForYouEventCard extends StatefulWidget {
  final RecommendedEvent event;
  const ForYouEventCard({super.key, required this.event});
  static String id = 'ForYouEventCard';
  @override
  State<ForYouEventCard> createState() => _EventCardState();
}

class _EventCardState extends State<ForYouEventCard> {
  @override
  Widget build(BuildContext context) {
    final formattedDate = widget.event.startDate != null
        ? DateFormat('yyyy-MM-dd – HH:mm')
            .format(widget.event.startDate!.toLocal())
        : 'Unknown date';
    return Padding(
      padding: EdgeInsets.only(left: 15.w, top: 5.h),
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
                        image: NetworkImage(widget.event.eventPicture!),
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
                          widget.event.eventName!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Styles.styleText20,
                        ),
                        Text(
                          formattedDate,
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
                      child: BlocConsumer<AddinterestCubit, AddinterestStates>(
                          listener: (context, state) {
                        if (state is AddInterestSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message.message)),
                          );
                        }
                        if (state is AddInterestErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      }, builder: (context, state) {
                        bool isInterested = widget.event.isInterested!;
                        return RiveAnimatedIcon(
                          riveIcon: RiveIcon.star,
                          width: 12.w,
                          height: 12.h,
                          color: Colors.blue,
                          strokeWidth: 3,
                          loopAnimation: false,
                          onTap: () {
                            if (isInterested) {
                              context
                                  .read<DeleteinterestCubit>()
                                  .deleteInterest(widget.event.eventId!);
                            } else {
                              context
                                  .read<AddinterestCubit>()
                                  .addInterest(widget.event.eventId!);
                            }
                          },
                          onHover: (value) {},
                        );
                      })),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
