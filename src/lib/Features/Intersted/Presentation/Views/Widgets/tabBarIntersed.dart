import 'package:eventk/Features/Intersted/Data/Models/getInterest_model.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/NoInterestedEventWidget.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/upComingIntersetLisView.dart';
import 'package:flutter/material.dart';

class Tabbarintersed extends StatelessWidget {
  const Tabbarintersed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.pink,
            tabs: [
              Tab(text: "Upcoming Events"),
              Tab(text: "Past Events"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                upComingInterestListView(name: 'upComing'),
                upComingInterestListView(name: 'past'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
