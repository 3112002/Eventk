import 'package:eventk/Core/widgets/EventWidget.dart';
import 'package:eventk/Features/Event/Presentaion/Views/EventPage.dart';
import 'package:flutter/material.dart';

class Intersedlistview extends StatefulWidget {
  const Intersedlistview({super.key, required this.events});
  final events;
  @override
  State<Intersedlistview> createState() => _IntersedlistviewState();
}

class _IntersedlistviewState extends State<Intersedlistview> {
  @override
  Widget build(BuildContext context) {
    return
        //untill take event widget
        ListView.builder(
      itemCount: widget.events.length,
      itemBuilder: (context, index) {
        final event = widget.events[index];

        return GestureDetector(
            onTap: () {
              print("Tapped event");
              print("Tapped eventId: ${event.eventId}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailsPage(
                    eventId: event.eventId,
                  ),
                ),
              );
            },
            //untill take event widget
            child: EventCard(event: event));
      },
    );
  }
}
