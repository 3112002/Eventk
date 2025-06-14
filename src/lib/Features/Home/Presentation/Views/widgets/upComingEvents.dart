import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/LoginRequiredButtonSheet.dart';
import 'package:eventk/Core/widgets/showLoginSheet.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_states.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/deleteInterest_cubit/deleteInterest_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';
/*Yara❤️*/

class UpComingEvents extends StatefulWidget {
  UpComingEvents({super.key, required this.item});
  final Item item;

  @override
  State<UpComingEvents> createState() => _UpComingEventsState();
}

class _UpComingEventsState extends State<UpComingEvents> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 9.w, top: 5.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 250.h, // Reduced from 300.h to fit listview height
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
                        image: CachedNetworkImageProvider(
                          widget.item!.eventPicture ?? AssestsImages.testImagePopluar,
                          errorListener: (err) =>
                              Image.asset(AssestsImages.testImagePopluar),
                        ),
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
                      child: BlocConsumer<AddinterestCubit, AddinterestStates>(
                          listener: (context, state) {
                        if (state is AddInterestSuccessState) {
                          /*
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message.message)),
                          );
                          */
                        } else if (state is AddInterestUnAuthorizedState) {
                          showLoginSheet(context);
                        } else if (state is AddInterestErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      }, builder: (context, state) {
                        bool? isInterested = widget.item.isInterested;
                        return IconButton(
                          icon: widget.item.isInterested == true
                              ? Icon(Icons.star)
                              : Icon(Icons.star_border_outlined),
                          color: Colors.blue,
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
                            }
                          },
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

