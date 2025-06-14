import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/AuthProvider.dart';
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Core/widgets/showLoginSheet.dart';
import 'package:eventk/Features/Event/Presentaion/Manager/cubits/eventCubit/eventCubit.dart';
import 'package:eventk/Features/Event/Presentaion/Manager/cubits/eventCubit/event_states';
import 'package:eventk/Features/Event/Presentaion/Views/Widgets/InfoTile.dart';
import 'package:eventk/Features/Event/Presentaion/Views/Widgets/openMap.dart';
import 'package:eventk/Features/Home/Presentation/Views/organizationDeatlis.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/organization.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/addInterest_cubit/addInterest_cubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/deleteInterest_cubit/deleteInterest_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/views/OrganizerPage.dart';
import 'package:eventk/Features/Payment/Presentation/views/TicketSelectionPage.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class EventpageBody extends StatefulWidget {
  final int eventId;
  const EventpageBody({super.key, required this.eventId});

  @override
  State<EventpageBody> createState() => _EventpageBodyState();
}

class _EventpageBodyState extends State<EventpageBody> {
  @override
  void initState() {
    super.initState();
    context.read<Eventcubit>().fetchEventDetails(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<Eventcubit, EventStates>(
        listener: (context, state) {
          if (state is EventErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.error}")),
            );
          }
        },
        builder: (context, state) {
          if (state is EventLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventLoadedState) {
            Future<String> getAddress(double lat, double lng) async {
              try {
                List<Placemark> placemarks =
                    await placemarkFromCoordinates(lat, lng);
                Placemark place = placemarks[0];
                return "${place.street}, ${place.locality}, ${place.country}";
              } catch (e) {
                return "Unknown location";
              }
            }

            final event = state.event;
            final formatedStaerDate = DateFormat('EEE, dd MMM, yyyy - hh:mm a')
                .format(DateTime.parse(event.startDate));
            final formatedEndDate = DateFormat('EEE, dd MMM, yyyy - hh:mm a')
                .format(DateTime.parse(event.endDate));

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 180.h,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      final isCollapsed =
                          constraints.biggest.height <= kToolbarHeight + 20;
                      return FlexibleSpaceBar(
                        title: isCollapsed
                            ? Text(
                                event.eventName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              )
                            : null,
                        background: Image.network(
                          event.eventPicture,
                          width: double.infinity,
                          height: 180.h,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, top: 20.h),
                        child: Text(
                          event.eventName,
                          // "Standup Comedy Show By Out Of Eight",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                blurRadius: 2.0,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      //the organizer logo untill make it
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(children: [
                          /*
                          Image.asset(
                            AssestsImages.profileAvatar,
                            width: 26.w,
                            height: 26.h,
                          ),
                          */
                          SizedBox(width: 8.w),
                          /*
                          Expanded(
                            child: Text(
                              'Organized by ${event.organizationName}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: const Color.fromARGB(255, 129, 126, 126),
                              ),
                             
                            ),
                          ),
                          */
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color:
                                      const Color.fromARGB(255, 129, 126, 126),
                                ),
                                children: [
                                  const TextSpan(text: 'Organized by '),
                                  TextSpan(
                                    text: event.organizationName,
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => OrganizerPage(
                                              organizationId:
                                                  event.organizationId,
                                            ),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Text(
                          "Highlights",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today,
                            color: kButtonsColor),
                        title: Text(
                          'From  $formatedStaerDate\nTo       $formatedEndDate',
                        ),
                      ),
                      //get Location from latitude,....

                      (event.latitude != null && event.longitude != null)
                          ? ListTile(
                              onTap: () async {
                                MapUtils.openMap(
                                    event.latitude!, event.longitude!);
                              },
                              leading: const Icon(Icons.location_on,
                                  color: kButtonsColor),
                              title: FutureBuilder<String>(
                                future: getAddress(
                                    event.latitude!, event.longitude!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text("Loading location...");
                                  } else if (snapshot.hasError ||
                                      !snapshot.hasData) {
                                    return const Text("Location not found");
                                  } else {
                                    return Text(snapshot.data!);
                                  }
                                },
                              ),
                            )
                          : const ListTile(
                              leading:
                                  Icon(Icons.location_on, color: kButtonsColor),
                              title: Text("Location not available"),
                            ),

                      Infotile(
                          icon: Icons.people_alt_outlined,
                          title:
                              'You and ${event.interestedPeople} others are interested'),
                      Infotile(
                        icon: (event.minPrice != null && event.maxPrice != null)
                            ? Icons.payment
                            : Icons.money_off,
                        title: (event.maxPrice == null &&
                                event.minPrice == null)
                            ? 'Free Event'
                            : (event.minPrice == event.maxPrice)
                                ? '${event.minPrice} EGP'
                                : '${event.minPrice} - ${event.maxPrice} EGP',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 20.h),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              if (event.isInterested == true) {
                                context
                                    .read<DeleteinterestCubit>()
                                    .deleteInterest(event.eventId);
                              } else {
                                context
                                    .read<AddinterestCubit>()
                                    .addInterest(event.eventId);
                              }
                            },
                            icon: Icon(
                                event.isInterested == true
                                    ? Icons.star
                                    : Icons.star_border,
                                color: event.isInterested == true
                                    ? Color(0xFFFFD700)
                                    : Colors.white,
                                size: 22.sp),
                            label: Text(
                              "Interested",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                letterSpacing: 0.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF607D8B),
                              elevation: 6,
                              shadowColor: Colors.black45,
                              minimumSize: Size(250.w, 48.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: event.isPaid
                              ? ElevatedButton(
                                  onPressed: ()async {
                                    final token = await CacheHelper().getDataString(key: 'token');

                                    /*
                                    final authProvider =
                                        Provider.of<Authprovider>(context,
                                            listen: false);
                                            */
                                   // if (authProvider.isLoggedIn) {
                                   if (token != null && token.isNotEmpty) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TicketSelectionPage(
                                                    eventId: widget.eventId,
                                                  )));
                                    } else {
                                      //An error page appear when the user not login
                                      showLoginSheet(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kButtonsColor,
                                    minimumSize:
                                        const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "Find Tickets",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kButtonsColor,
                                    minimumSize:
                                        const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "I'am Interested",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'About',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: Wrap(
                          spacing: 8.w,
                          runSpacing: 4.h,
                          children: event.categories.isNotEmpty
                              ? event.categories.map((category) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 9.h),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF0000FF),
                                          Color(0xFF3F51B5),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      category,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  );
                                }).toList()
                              : [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      "No Category",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          event.description,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color.fromARGB(255, 92, 89, 89),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
