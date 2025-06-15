// import 'package:dio/dio.dart';
// import 'package:eventk/Core/Services/get_it_services.dart';
// import 'package:eventk/Core/utils/assests.dart';
// import 'package:eventk/Core/utils/get_Interest_service.dart';
// import 'package:eventk/Core/utils/interset_model/interset_model.dart';
// import 'package:eventk/Features/Home/Data/model/get_events_model/item.dart';
// import 'package:eventk/Features/Intersted/Data/Models/getInterest_model.dart';
// import 'package:eventk/Features/Intersted/Domain/InterestedRepo.dart';
// import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/NoInterestedEventWidget.dart';
// import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/tabBarIntersed.dart';
// import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/getInterest_cubit/getInterest_cubit.dart';
// import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/getInterest_cubit/getInterest_states.dart';
// import 'package:eventk/Features/Intersted/Presentation/Views/manager2/getIntCubit.dart';
// import 'package:eventk/Features/Intersted/Presentation/Views/manager2/getIntState.dart';
// import 'package:eventk/helper/api.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class FavouritesPage extends StatefulWidget {
//   static String id = 'InterestedPage';
//   const FavouritesPage({super.key});
import 'package:dio/dio.dart';
import 'package:eventk/Core/utils/get_Interest_service.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/intersetAllPage.dart';
import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/getInterest_cubit/getInterest_cubit.dart';
import 'package:eventk/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => GetinterestCubit(
              service: GetInterestService(api: Api(dio: Dio())))),
    ], child: Intersetallpage());
  }
}

//   @override
//   State<FavouritesPage> createState() => _FavouritesPageState();
// }

// class _FavouritesPageState extends State<FavouritesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: BlocProvider(
//         create: (context) => Getintcubit(getIt<Interestedrepo>())..GetList(),
//         child: BlocBuilder<Getintcubit, Getintstate>(

//           builder: (context, state) {
//             List upcomingEvents = [];
//             List pastEvents = [];
//             if (state is SuccessGetIntState) {
//               final now = DateTime.now().millisecondsSinceEpoch;
//               upcomingEvents = state.getList.where((event) {
//                 if (event.startDate == null) return false;

//                 final DateTime? eventTime;
//                 try {
//                   eventTime = event.startDate is DateTime
//                       ? event.startDate
//                       : DateTime.tryParse(event.startDate.toString())
//                           ?.toLocal();
//                 } catch (e) {
//                   return false;
//                 }

//                 if (eventTime == null) return false;

//                 return eventTime.isAfter(DateTime.now());
//               }).toList();
//               return  //untill take event widget
//         ListView.builder(
//       itemCount: widget.events.length,
//       itemBuilder: (context, index) {
//         final event = widget.events[index];

//         return GestureDetector(
//             onTap: () {
//               print("Tapped event");
//               print("Tapped eventId: ${event.eventId}");
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => EventDetailsPage(
//                     eventId: event.eventId,
//                   ),
//                 ),
//               );
//             },
//             //untill take event widget
//             child: EventCard(event: event));
//       },
//     );
//             }

//             return Scaffold(
//               appBar: AppBar(
//                 toolbarHeight: 80.h,
//                 automaticallyImplyLeading: false,
//                 flexibleSpace: Image.asset(
//                   AssestsImages.backgroundEvents,
//                   fit: BoxFit.cover,
//                 ),
//                 centerTitle: true,
//                 title: Text(
//                   "Events that You're Interested In",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               body: Tabbarintersed(
//                   upcomingEvents: upcomingEvents, pastEvents: pastEvents),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
