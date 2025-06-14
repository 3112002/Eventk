import 'package:dio/dio.dart';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/utils/get_events_service.dart';
import 'package:eventk/Core/widgets/customErrorWidgets.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Event/Presentaion/Views/EventPage.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/get_events_model.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_state.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/eventsNearYouListViewLoadingIndicator.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/popularEvents.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/showMoreEvents.dart';
import 'package:eventk/Features/Home/domain/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel*/
class Populareventslistview extends StatelessWidget {
  const Populareventslistview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            GetEventsCubit(getIt<HomeRepo>())..GetEvents('', 0),
        child: BlocBuilder<GetEventsCubit, GetEventsState>(
          builder: (context, state) {
            if (state is SuccessGetEventsState) {
              GetEventsModel events = state.events;
              List<Item> items = events.items;
              return SizedBox(
                height: 250.h,
                child: ListView.builder(
                    itemCount: items.length + 1,
                    scrollDirection: Axis.horizontal,
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
                                child: PopularEvents(item: items[index]));
                       
                      } else {
                        return ShowMoreEvents(
                          endPoint: '',
                        );
                      }
                    }),
              );
            } else if (state is FailureGetEventsState) {
              return CustomErrorWidgets(errMessage: state.errMessage);
            } else {
              return EventsNearYouListViewLoadingIndicator();
            }
          },
        ));
  }
}
