import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/AuthProvider.dart';
import 'package:eventk/Core/utils/User%E2%80%99sLatitudeaLongitude.dart';
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/eventsNearYouListView.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/eventsNearYouListViewLoadingIndicator.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/exploreCategoriesListView.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/homeText.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/iconNotification.dart';
import 'package:eventk/Core/widgets/searchTextField.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/organizationListView.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/popularEventsListView.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/upComingEventsDate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

/*Yara Adel Mohamed EL-Sayed*/
class HomePage extends StatefulWidget {
  HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

double? lat, long;
bool loadingLocation = true;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    location();
  }

  Future<void> location() async {
    await Userislatitudealongitude().GetLocation();
    final newLat = getIt<CacheHelper>().getData(key: 'latitude');
    final newLong = getIt<CacheHelper>().getData(key: 'longitude');
    setState(() {
      lat = newLat;
      long = newLong;
      loadingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        automaticallyImplyLeading: false,
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
              comeFrom: 'Home',
            )),
            IconNotification(),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 30.h, left: 8.w)),
                HomeTextHeading(text: 'Explore Categories'),
                Padding(padding: EdgeInsets.only(top: 12.h)),
                Explorecategorieslistview(),
                HomeTextHeading(text: 'Popular Events'),
                Populareventslistview(),
                HomeTextHeading(text: 'Events Near For You'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: loadingLocation
                      ? SizedBox(
                          height: 250.h,
                          child: EventsNearYouListViewLoadingIndicator(),
                        )
                      : EventsNearYouListView(lat: lat!, long: long!),
                ),
                //HomeTextHeading(text: 'Upcoming Events'),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Text(
                      'Upcoming Events',
                      style: Styles.styleText20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 350.h,
                  child: const UpComingEventsDate(),
                ),
                //HomeTextHeading(text: 'Organization to follow'),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: 
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OrganizationListView(),
                  )
               
          ),
        ],
      ),
    );
  }
}
