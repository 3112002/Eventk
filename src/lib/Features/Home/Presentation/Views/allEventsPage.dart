import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Core/widgets/searchTextField.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/get_events_model.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/allEventsFilterTabBar.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/iconNotification.dart';

import 'package:eventk/Features/Home/Presentation/Views/widgets/modelBottomSheet.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/seeMoreEventsDetalies.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/seeMoreEventsListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel Mohamed❤️*/
class AllEventsPage extends StatefulWidget {
  const AllEventsPage(
      {super.key, this.endPoint, this.name, this.date, this.isPaid});
  final String? endPoint;
  final String? name;
  final String? date;
  final bool? isPaid;

  @override
  State<AllEventsPage> createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  String? newEndPoint;
  @override
  void initState() {
    super.initState();
    newEndPoint = widget.endPoint;
    tabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  void handleTabChange() {
    if (tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> showFilterSheet(BuildContext context, int index) async {
    final result = await showModalBottomSheet(
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
            child: ModelBottomSheet(
              selectedIndex: index,
              name: widget.name,
              date: widget.date,
              isPaid: widget.isPaid,
            ));
      },
    );

    if (result != null) {
      setState(() {
        newEndPoint = result;
      });
    }
  }

/********************************************************************************************************** */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Image(
          image: AssetImage(AssestsImages.backgroundEvents),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: SearchFields(
              comeFrom: 'Filter',
              onSearch: (query) {
                setState(() {
                  newEndPoint = 'Name=${query}';
                });
              },
            )),
            IconNotification(),
          ],
        ),
      ),
      body: Column(
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
                  await showFilterSheet(context, index - 1);
                  //  tabController.animateTo(index);
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
              child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                SeeMoreEventsListView(
                  endPoint: newEndPoint,
                ),
                // SeeMoreEventsListView(
                //   endPoint: newEndPoint,
                // ),
                // SeeMoreEventsListView(
                //   endPoint: newEndPoint,
                // ),
                // SeeMoreEventsListView(
                //   endPoint: newEndPoint,
                // ),
                // SeeMoreEventsListView(
                //   endPoint: newEndPoint,
                // ),
              ])),
        ],
      ),
    );
  }
}
