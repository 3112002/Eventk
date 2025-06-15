import 'package:eventk/Core/widgets/EventWidget.dart';
import 'package:eventk/Core/widgets/searchTextField.dart';
import 'package:eventk/Features/Event/Presentaion/Views/EventPage.dart';
import 'package:eventk/Features/Home/Presentation/Views/allEventsPage.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/doesnotExitInterset.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/intersedListView.dart';
import 'package:eventk/Features/Search/Presentation/Views/searchPage.dart';
import 'package:flutter/material.dart';

class Nointerestedeventwidget extends StatefulWidget {
  final List events;
  const Nointerestedeventwidget({super.key, required this.events});

  @override
  State<Nointerestedeventwidget> createState() =>
      _NointerestedeventwidgetState();
}

class _NointerestedeventwidgetState extends State<Nointerestedeventwidget> {
  @override
  Widget build(BuildContext context) {
    return widget.events.isEmpty
        ? Doesnotexitinterset()
        : Intersedlistview(
            events: widget.events,
          );
  }
}
