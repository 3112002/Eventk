import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/utils/interset_model/interset_model.dart';
import 'package:eventk/Core/widgets/EventWidget.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Event/Presentaion/Views/EventPage.dart';
import 'package:eventk/Features/Home/Presentation/Manager/get_events_state.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/customExcptionWidget.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/eventsNearYouListViewLoadingIndicator.dart';
import 'package:eventk/Features/Intersted/Domain/InterestedRepo.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/getIntersetListViewLoadingIndicator.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/getIntCubit.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager2/getIntState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class upComingInterestListView extends StatelessWidget {
  const upComingInterestListView({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Getintcubit(getIt<Interestedrepo>())..GetList(),
        child: BlocBuilder<Getintcubit, Getintstate>(builder: (context, state) {
          List<IntersetModel> upcomingEvents = [];
          List<IntersetModel> pastEvents = [];
          if (state is SuccessGetIntState) {
            final now = DateTime.now().millisecondsSinceEpoch;
            upcomingEvents = state.getList.where((event) {
              if (event.startDate == null) return false;

              final DateTime? eventTime;
              try {
                eventTime = event.startDate is DateTime
                    ? event.startDate
                    : DateTime.tryParse(event.startDate.toString())?.toLocal();
              } catch (e) {
                return false;
              }

              if (eventTime == null) return false;

              return eventTime.isAfter(DateTime.now());
            }).toList();
            pastEvents = state.getList.where((event) {
              if (event.startDate == null) return false;

              final DateTime? eventTime;
              try {
                eventTime = event.startDate is DateTime
                    ? event.startDate
                    : DateTime.tryParse(event.startDate.toString())?.toLocal();
              } catch (e) {
                return false;
              }

              if (eventTime == null) return false;

              return eventTime.isBefore(DateTime.now());
            }).toList();

            return //untill take event widget
                ListView.builder(
              itemCount: name == 'upComing'
                  ? upcomingEvents.length
                  : pastEvents.length,
              itemBuilder: (context, index) {
                final eventid = name == 'upComing'
                    ? upcomingEvents[index].eventId
                    : pastEvents[index].eventId;
                final event = name == 'upComing'
                    ? upcomingEvents[index]
                    : pastEvents[index];
                return GestureDetector(
                    onTap: () {
                      print("Tapped event");
                      // print("Tapped eventId: ${event.eventId}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventDetailsPage(
                            eventId: eventid!,
                          ),
                        ),
                      );
                    },
                    //untill take event widget

                    child: EventCard(event: event));
              },
            );
          } else if (state is FailureGetEventsState) {
            return CustomExcptionWidget();
          } else {
            return Getintersetlistviewloadingindicator();
          }
        }));
  }
}
