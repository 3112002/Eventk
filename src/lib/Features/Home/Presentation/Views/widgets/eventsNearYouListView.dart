import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/User%E2%80%99sLatitudeaLongitude.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Event/Presentaion/Views/EventPage.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/get_events_model.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_state.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_near_events_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/eventsNearYou.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/eventsNearYouListViewLoadingIndicator.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/showMoreEvents.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel Mohamed*/

class EventsNearYouListView extends StatefulWidget {
  EventsNearYouListView({super.key, this.lat, this.long});
  final double? lat;
  final double? long;
  @override
  State<EventsNearYouListView> createState() => _EventsNearYouListViewState();
}

class _EventsNearYouListViewState extends State<EventsNearYouListView> {
  Future<void> location() async {
    await Userislatitudealongitude().GetLocation();
  }

  @override
  void initState() {
    super.initState();
    // location();
  }

  @override
  Widget build(BuildContext context) {
    // widget.lat = null;
    // widget.long = null;
    String endPoint = 'Latitude=${widget.lat}&Longitude=${widget.long}';
    // String endPoint =
    //GetNearEvents ""
    //   '?Latitude=${getIt<CacheHelper>().getData(key: 'latitude')}&Longitude=${getIt<CacheHelper>().getData(key: 'longitude')}';
    return BlocProvider(
        create: (context) =>
            GetEventsCubit(getIt<HomeRepo>())..GetEvents(endPoint, 0),
        child: BlocBuilder<GetEventsCubit, GetEventsState>(
            builder: (context, state) {
          if (state is SuccessGetEventsState) {
            GetEventsModel events = state.events;
            List<Item> items = events.items;
            if (items.isEmpty) {
              return SizedBox(
                height: 70.h,
                child: Center(
                    child: Text(
                  "No nearby events found",
                  style: Styles.styleText20,
                )),
              );
            }
            return SizedBox(
              height: 250.h,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length + 1,
                        itemBuilder: (context, index) {
                          if (index < 5) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EventDetailsPage(
                                        eventId: items[index].eventId,
                                      ),
                                    ),
                                  );
                                },
                                child: EventsNearYou(item: items[index]));
                          } else {
                            return ShowMoreEvents(endPoint: endPoint);
                          }
                        }),
                  ),
                ],
              ),
            );
          } else if (state is FailureGetEventsState) {
            return ElevatedButton(
              onPressed: () async {
                try {
                  await Userislatitudealongitude().GetLocation();
                  double? newLat = widget.lat!;
                  double? newLong = widget.long!;
                  setState(() {
                    newLat = getIt<CacheHelper>().getData(key: 'latitude');
                    newLong = getIt<CacheHelper>().getData(key: 'longitude');
                    endPoint =
                        '?Latitude=${widget.lat}&Longitude=${widget.long}';
                  });

                  context.read<GetEventsCubit>().GetEvents(endPoint, 0);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('')));
                }
              },
              child: const Text("Get Current Location"),
            );
          } else {
            return EventsNearYouListViewLoadingIndicator();
          }
        }));
  }
}
