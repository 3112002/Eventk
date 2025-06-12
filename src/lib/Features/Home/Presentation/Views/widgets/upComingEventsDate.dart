import 'package:eventk/Features/Home/Presentation/Views/widgets/homeText.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/upComingEventsListView.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/upcomingEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Yara Adel Mohamed EL-Sayed❤️*/

class UpComingEventsDate extends StatefulWidget {
  const UpComingEventsDate({super.key});

  @override
  State<UpComingEventsDate> createState() => _UpComingEventsDateState();
}

final now = DateTime.now();
final DateTime today = DateTime(now.year, now.month, now.day);
final afterWeek = today.add(const Duration(hours: 168));
int currentWeekday = now.weekday; // 1 (Monday) - 7 (Sunday)
int daysUntil = (DateTime.thursday - currentWeekday + 7) % 7;

final DateTime nextThursday = today.add(Duration(days: daysUntil));

final DateTime endOfFriday =
    nextThursday.add(Duration(days: 2)).subtract(Duration(milliseconds: 1));

class _UpComingEventsDateState extends State<UpComingEventsDate> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Container(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 12.w), // Adjust spacing

                labelColor: Colors.blue,
                indicatorColor: Colors.blue,
                // indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.label,
                // tabAlignment: Alignment.centerLeft,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: 'This Weekend',
                  ),
                  Tab(
                    text: 'Today',
                  ),
                  Tab(
                    text: 'Tomorrow',
                  ),
                  Tab(
                    text: 'This Week',
                  ),
                  Tab(
                    text: 'Next Week',
                  ),
                  Tab(
                    text: 'This Month',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(children: [
              UpComingEventsListView(
                  fromDate: nextThursday,
                  toDate: endOfFriday,
                  name: 'This weekend'),
              UpComingEventsListView(
                fromDate: today,
                toDate: today.add(
                  Duration(hours: 24),
                ),
                name: 'To day',
              ),
              UpComingEventsListView(
                  fromDate: today.add(Duration(hours: 24)),
                  toDate: today.add(Duration(hours: 48)),
                  name: 'Tomorrow'),
              UpComingEventsListView(
                  fromDate: today, toDate: afterWeek, name: 'This week'),
              UpComingEventsListView(
                  fromDate: today.add(Duration(days: 7)),
                  toDate: today.add(
                    Duration(days: 14),
                  ),
                  name: 'Next week'),
              UpComingEventsListView(
                fromDate: today,
                toDate: DateTime(now.year, now.month + 1, 0),
                name: 'This year',
              ),
            ]),
          ),
          HomeTextHeading(text: 'Organization to follow'),
          Padding(padding: EdgeInsets.only(top: 10.h)),
        ],
      ),
    );
  }
}
