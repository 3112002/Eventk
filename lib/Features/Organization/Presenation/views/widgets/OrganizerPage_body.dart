import 'package:eventk/Features/Event/Presentaion/Views/EventPage.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/follow_unfollow_cubit/follow_unfollow_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/follow_unfollow_cubit/follow_unfollow_states.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/getOrganizationId_cubit/getOraganizationId_states.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/getOrganizationId_cubit/getOrganizationId_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/organizerToFollow_cubit/organizerToFollow_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/views/widgets/EventCard.dart';
import 'package:eventk/Features/Organization/Presenation/views/widgets/organization_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrganizerpageBody extends StatefulWidget {
  final int organizationId;

  const OrganizerpageBody({super.key, required this.organizationId});

  @override
  State<OrganizerpageBody> createState() => _OrganizerpageBodyState();
}

class _OrganizerpageBodyState extends State<OrganizerpageBody> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetorganizationidCubit>()
        .fetchOrganizationById(organizationId: widget.organizationId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetorganizationidCubit, GetoraganizationidStates>(
      listener: (context, state) {
        if (state is GetoraganizationidFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is GetoraganizationidLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetoraganizationidSuccessState) {
          final organization = state.organzation;

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrganizationHeader(logoUrl: organization.logo),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      organization.name ?? "Unknown Name",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Icon(Icons.people_alt_outlined,
                            size: 18.sp, color: Colors.grey[700]),
                        SizedBox(width: 5.w),
                        Text("${organization.followersCount} Followers",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500)),
                        SizedBox(width: 30.w),
                        Icon(Icons.event_note,
                            size: 18.sp, color: Colors.grey[700]),
                        SizedBox(width: 5.w),
                        Text("${organization.events.length} Events",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  if (organization.links.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 8.h),
                          ...organization.links.expand((link) sync* {
                            yield GestureDetector(
                              onTap: () async {
                                final rawUrl = link.linkUrl.trim();
                                final fixedUrl = rawUrl.startsWith('http')
                                    ? rawUrl
                                    : 'https://$rawUrl';

                                if (await canLaunchUrlString(fixedUrl)) {
                                  try {
                                    await launchUrlString(fixedUrl,
                                        mode: LaunchMode.inAppWebView);
                                  } catch (e) {
                                    await launchUrlString(fixedUrl,
                                        mode: LaunchMode.externalApplication);
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 6.h),
                                child: Text(
                                  link.linkName,
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15.sp,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            );
                            if (link != organization.links.last) {
                              yield SizedBox(width: 12.w);
                            }
                          }).toList(),
                        ],
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: 150.w,
                      child: BlocBuilder<FollowUnfollowCubit, FollowStates>(
                        builder: (context, followState) {
                          final isLoading = followState is FollowLoadingState &&
                              followState.orgId == widget.organizationId;

                          return ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    final followCubit =
                                        context.read<FollowUnfollowCubit>();
                                    final orgCubit =
                                        context.read<OrganizertofollowCubit>();

                                    if (organization.isFollowed!) {
                                      await followCubit.unfollowOrganization(
                                          organization.organizationId!);
                                    } else {
                                      await followCubit.followOrganization(
                                          organization.organizationId!);
                                    }

                                    await context
                                        .read<GetorganizationidCubit>()
                                        .fetchOrganizationById(
                                          organizationId: widget.organizationId,
                                        );
                                    await orgCubit.fetchOrganizationsToFollow(
                                        isFollowing: true);
                                    await orgCubit.fetchOrganizationsToFollow(
                                        isFollowing: false);
                                  },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(90.w, 30.h),
                              backgroundColor: organization.isFollowed == true
                                  ? Colors.grey[300]
                                  : Colors.blueAccent,
                              foregroundColor: organization.isFollowed == true
                                  ? Colors.black54
                                  : Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.w, vertical: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              elevation: 3,
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white),
                                  )
                                : Text(
                                    organization.isFollowed == true
                                        ? 'Following'
                                        : 'Follow',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const TabBar(
                    labelColor: Colors.blueAccent,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blueAccent,
                    tabs: [
                      Tab(text: "Events"),
                      Tab(text: "About"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.all(20.w),
                          itemCount: organization.events.length,
                          itemBuilder: (context, index) {
                            final event = organization.events[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => EventDetailsPage(
                                                eventId: event.eventId)));
                                  },
                                  child: OrganizationEventsCard(event: event)),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 25.0),
                          child: Text(
                            organization.desc ?? "No description available",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              height: 1.6,
                              letterSpacing: 0.5,
                              shadows: [
                                Shadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
