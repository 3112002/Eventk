import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/organizerToFollow_cubit/organizerToFollow_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/views/widgets/FollowingBar.dart';
import 'package:eventk/Features/Organization/Presenation/views/widgets/ToFollowBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizerspageBody extends StatefulWidget {
  const OrganizerspageBody({super.key});

  @override
  State<OrganizerspageBody> createState() => _OrganizerspageBodyState();
}

class _OrganizerspageBodyState extends State<OrganizerspageBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    context
        .read<OrganizertofollowCubit>()
        .fetchOrganizationsToFollow(isFollowing: false);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      if (_tabController.index == 0) {
        context
            .read<OrganizertofollowCubit>()
            .fetchOrganizationsToFollow(isFollowing: false);
      } else if (_tabController.index == 1) {
        context
            .read<OrganizertofollowCubit>()
            .fetchOrganizationsToFollow(isFollowing: true);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                AssestsImages.backgroundEvents,
                width: double.infinity,
                height: 100.h,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 12.h,
                left: 14.w,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 45.h),
                  child: Text(
                    "Organizers",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blueAccent,
            tabs: const [
              Tab(text: "To Follow"),
              Tab(text: "Following"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Tofollowbar(),
                Followingbar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
