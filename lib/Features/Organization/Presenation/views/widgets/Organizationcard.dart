import 'package:eventk/Features/Organization/Data/models/OrganizationToFollowModel.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/follow_unfollow_cubit/follow_unfollow_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/follow_unfollow_cubit/follow_unfollow_states.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/organizerToFollow_cubit/organizerToFollow_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/views/OrganizerPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Organizationcard extends StatelessWidget {
  final Organizationtofollowmodel organization;
  const Organizationcard({super.key, required this.organization});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FollowUnfollowCubit, FollowStates>(
      listener: (context, state) {
        if (state is FollowFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is FollowSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is FollowLoadingState &&
            state.orgId == organization.organizationId;
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OrganizerPage(
                          organizationId: organization.organizationId,
                        )));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.network(
                        organization.logo ?? '',
                        width: 55.w,
                        height: 55.h,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(Icons.broken_image,
                            size: 50, color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            organization.name ?? "Un Known name",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${organization.followersCount ?? 0} Followers',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
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
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Divider(
                  thickness: 1.2,
                  color: Colors.grey[300],
                  endIndent: 16.w,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
