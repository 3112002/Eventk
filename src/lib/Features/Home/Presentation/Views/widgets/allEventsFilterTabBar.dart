import 'package:eventk/Features/Home/Presentation/Views/widgets/modelBottomSheet.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/seeMoreEventsListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel Mohamed❤️*/
class AllEventsFilterTabBar extends StatefulWidget {
  const AllEventsFilterTabBar({super.key, this.endPoint});
  final String? endPoint;
  @override
  State<AllEventsFilterTabBar> createState() => _AllEventsFilterTabBarState();
}

class _AllEventsFilterTabBarState extends State<AllEventsFilterTabBar>
    with TickerProviderStateMixin {
  late TabController tabController;
  String? currentEndpoint;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 5,
      vsync: this,
    )..addListener(handleTabChange);
    currentEndpoint = widget.endPoint;
  }

  void handleTabChange() {
    if (tabController.indexIsChanging) {
      setState(() {});
    }
  }

  Future<String?> showFilterSheet(BuildContext context, int index) async {
    return await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      elevation: 8,
      barrierColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
      builder: (context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ModelBottomSheet(selectedIndex: index));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 50.h,
          child: TabBar(
              controller: tabController,
              labelColor: Colors.blue,
              labelPadding: EdgeInsets.only(left: 0.w, right: 30.w),
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              indicatorPadding: EdgeInsets.only(bottom: 4.h),
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              onTap: (index) async {
                if (index == 0) return;
                final result = await showFilterSheet(context, index - 1);
                if (result != null && result != currentEndpoint) {
                  setState(() {
                    currentEndpoint = result;
                  });
                }
                tabController.animateTo(index);
              },
              tabs: [
                Tab(
                  icon: Icon(Icons.tune),
                ),
                Tab(text: 'Category'),
                Tab(text: 'Date'),
                Tab(text: 'Distance'),
                Tab(text: 'Price'),
              ]),
        ),
        Expanded(
            child: TabBarView(controller: tabController, children: [
          SeeMoreEventsListView(
            endPoint: currentEndpoint,
          ),
          SeeMoreEventsListView(
            endPoint: currentEndpoint,
          ),
          SeeMoreEventsListView(
            endPoint: currentEndpoint,
          ),
          SeeMoreEventsListView(
            endPoint: currentEndpoint,
          ),
          SeeMoreEventsListView(
            endPoint: currentEndpoint,
          ),
        ])),
      ],
    );
  }
}
