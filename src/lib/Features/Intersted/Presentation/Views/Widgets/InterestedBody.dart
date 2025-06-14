// import 'package:eventk/Core/utils/assests.dart';
// import 'package:eventk/Features/Intersted/Presentation/Views/Widgets/NoInterestedEventWidget.dart';
// import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/getInterest_cubit/getInterest_cubit.dart';
// import 'package:eventk/Features/Intersted/Presentation/Views/manager/cubits/getInterest_cubit/getInterest_states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Interestedbody extends StatelessWidget {
//   const Interestedbody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     context.read<GetinterestCubit>().fetchInterests();
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: Column(
//           children: [
//             Stack(
//               children: [
//                 Image.asset(
//                   AssestsImages.backgroundEvents,
//                   width: double.infinity,
//                   height: 100.h,
//                   fit: BoxFit.cover,
//                 ),
//                 Positioned(
//                   bottom: 20,
//                   left: 16,
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 45.h),
//                     child: Text(
//                       "Events that You're Interested In",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const TabBar(
//               labelColor: Colors.pink,
//               unselectedLabelColor: Colors.grey,
//               indicatorColor: Colors.pink,
//               tabs: [
//                 Tab(text: "Upcoming Events"),
//                 Tab(text: "Past Events"),
//               ],
//             ),
//             Expanded(
//               child: BlocConsumer<GetinterestCubit, GetinterestStates>(
//                 listener: (context, state) {
//                   if (state is GetInterestErrorState) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text(state.message)),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is GetInterestLoadingState) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (state is GetInterestLoadedState) {
//                     final now = DateTime.now();
//                     final upcomingEvents = state.interests.where((event) {
//                       final date = DateTime.parse(event.startDate);

//                       return date.isAfter(now);
//                     }).toList();
//                     final pastEvents = state.interests.where((event) {
//                       final date = DateTime.parse(event.startDate);
//                       return date.isBefore(now);
//                     }).toList();
//                     return TabBarView(children: [
//                       Nointerestedeventwidget(
//                         events: upcomingEvents,
//                       ),
//                       Nointerestedeventwidget(
//                         events: pastEvents,
//                       ),
//                     ]);
//                   } else {
//                     return const SizedBox.shrink();
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
