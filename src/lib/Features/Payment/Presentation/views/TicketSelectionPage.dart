import 'package:dio/dio.dart';
import 'package:eventk/Core/utils/ticketTypes_service.dart';
import 'package:eventk/Features/Payment/Presentation/manager/findTicket_cubit/findTicket_cubit.dart';
import 'package:eventk/Features/Payment/Presentation/views/widgets/TicketSelectionPage_body.dart';
import 'package:eventk/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketSelectionPage extends StatefulWidget {
  final int eventId;
  const TicketSelectionPage({super.key, required this.eventId});

  @override
  State<TicketSelectionPage> createState() => _TicketSelectionPageState();
}

class _TicketSelectionPageState extends State<TicketSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => FindticketCubit(
                  service: TickettypesService(api: Api(dio: Dio())))),
        ],
        child: TicketselectionpageBody(
          eventId: widget.eventId,
        ));
  }
}
