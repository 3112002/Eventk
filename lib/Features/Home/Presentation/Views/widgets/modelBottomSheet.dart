import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/categortFilterUI.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/dateCategoryUI.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/distanceFilterUI.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/priceFilterUI.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/turnOnLocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel Mohamed*/
class ModelBottomSheet extends StatefulWidget {
  const ModelBottomSheet({super.key, this.selectedIndex, this.name});
  final int? selectedIndex;
  final String? name;
  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

final now = DateTime.now();
final DateTime today = DateTime(now.year, now.month, now.day);
final afterWeek = today.add(const Duration(hours: 168));
int currentWeekday = now.weekday; // 1 (Monday) - 7 (Sunday)
int daysUntil = (DateTime.thursday - currentWeekday + 7) % 7;

final DateTime nextThursday = today.add(Duration(days: daysUntil));

final DateTime endOfFriday =
    nextThursday.add(Duration(days: 2)).subtract(Duration(milliseconds: 1));
DateTime? fromDate;
DateTime? toDate;

class _ModelBottomSheetState extends State<ModelBottomSheet>
    with TickerProviderStateMixin {
  late TabController tabController;
  String? selectedCategory;
  String? selectedDate;
  double? selectedDistanceKm;
  double? selectedMinPrice;
  double? selectedMaxPrice;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.selectedIndex ?? 0,
    );
    getIt<CacheHelper>().saveData(key: 'selectedDate', value: widget.name);
    tabController.addListener(handleTabChange);
    selectedDate =
        getIt<CacheHelper>().getData(key: 'selectedDate') ?? widget.name;

    print(widget.selectedIndex);
  }

  void handleTabChange() {
    if (tabController.indexIsChanging) {
      setState(() {});
    }
  }

  final address = getIt<CacheHelper>().getData(key: 'address');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 10.w,
            height: 5.h,
            decoration: BoxDecoration(),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20.h, left: 10.w)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Filters',
                style: Styles.styleText20,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
          ],
        ),
        DefaultTabController(
          length: 4,
          child: SizedBox(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  controller: tabController,
                  labelColor: Colors.blue,
                  labelPadding: EdgeInsets.only(
                    left: 0.w,
                  ),
                  indicatorColor: Colors.blue,
                  indicatorWeight: 3,
                  indicatorPadding: EdgeInsets.only(bottom: 4.h),
                  indicatorSize: TabBarIndicatorSize.label,
                  onTap: (index) {
                    if (index < 5) {
                      return;
                    }
                    tabController.animateTo(index);
                  },
                  tabs: [
                    Tab(text: 'Category'),
                    Tab(text: 'Date'),
                    Tab(text: 'Distance'),
                    Tab(text: 'Price'),
                  ]),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(controller: tabController, children: [
            CategoryFilterUI(
              initialValue: widget.name,
            ),
            DateFilterUI(
              initialValue: selectedDate,
              onChanged: (opt) => setState(() {
                selectedDate = opt;
                if (selectedDate == 'This weekend') {
                  fromDate = nextThursday;
                  toDate = endOfFriday;
                } else if (selectedDate == 'This week') {
                  fromDate = today;
                  toDate = afterWeek;
                } else if (selectedDate == 'To day') {
                  fromDate = today;
                  toDate = today.add(
                    Duration(hours: 24),
                  );
                } else if (selectedDate == 'Next week') {
                  fromDate = today.add(Duration(days: 7));
                  toDate = today.add(
                    Duration(days: 14),
                  );
                } else if (selectedDate == 'This yean') {
                  fromDate = today;
                  toDate = DateTime(now.year, now.month + 1, 0);
                } else if (selectedDate == 'Tomorrow') {
                  fromDate = today.add(Duration(hours: 24));
                  toDate = today.add(Duration(hours: 48));
                }
              }),
            ),
            address == null ? TurnOnLocation() : DistanceFilterUI(),
            PriceFilterUI(),
          ]),
        ),
        Divider(
          color: Colors.black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  String endPoint = '?';
                  // if (getIt<CacheHelper>().getData(key: 'categoryName') !=
                  //     null) {
                  //   endPoint = endPoint +
                  //       '&CategoriesIds=${getIt<CacheHelper>().getData(key: 'categoryId')}';
                  // }
                  if (getIt<CacheHelper>().getData(key: 'selectedDate') !=
                      null) {
                    endPoint =
                        endPoint + '&FromDate=${fromDate}&ToDate=${toDate}';
                  }

                  getIt<CacheHelper>()
                      .saveData(key: 'endPoint', value: endPoint);

                  Navigator.pop(context, endPoint);
                },
                child: Text('Apply'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
                onPressed: () {
                  String endPoint = '';
                  Navigator.pop(context, endPoint);
                },
                child: Text('Clear all'),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30.h))
      ],
    );
  }
}
