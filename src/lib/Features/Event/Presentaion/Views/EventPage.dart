import 'package:dio/dio.dart';
import 'package:eventk/Core/utils/Event_Service.dart';
import 'package:eventk/Features/Event/Presentaion/Manager/cubits/eventCubit/eventCubit.dart';
import 'package:eventk/Features/Event/Presentaion/Views/Widgets/EventPage_body.dart';
import 'package:eventk/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailsPage extends StatelessWidget {
  final int eventId;
  const EventDetailsPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              Eventcubit(service: EventService(api: Api(dio: Dio())))),
    ], child: EventpageBody(eventId: eventId));
  }
}
