import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/showLoginSheet.dart';
import 'package:eventk/Features/Home/Data/model/organizationModel.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/follow_unfollow_cubit/follow_unfollow_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/follow_unfollow_cubit/follow_unfollow_states.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/getOrganizationId_cubit/getOrganizationId_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/organizerToFollow_cubit/organizerToFollow_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Yara❤️*/

bool isFollow = true;

class Organization extends StatefulWidget {
  Organization({super.key, required this.organizationss});
  OrganizationModel organizationss;

  @override
  State<Organization> createState() => _OrganizationState();
}

class _OrganizationState extends State<Organization> {
  bool isLoading = false;
  /*
  @override
  void initState() {
    super.initState();
    isFollow = widget.organizationss.isFollowed ?? true;
  }
*/
  @override
  Widget build(BuildContext context) {
    print(widget.organizationss.organizationId);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(padding: EdgeInsets.only(top: 20.h)),
        Container(
          height: 80.h,
          width: 80.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.organizationss.logo ?? ''),
              ),
              borderRadius: BorderRadius.circular(150)),
        ),
        Padding(padding: EdgeInsets.only(left: 10.w)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.organizationss.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Styles.styleText14,
              ),
              Text(
                '${widget.organizationss.followersCount} Followers',
                style: Styles.styleText14.copyWith(color: Colors.grey),
              ),
             BlocBuilder<FollowUnfollowCubit, FollowStates>(
  builder: (context, followState) {
    final isLoading = followState is FollowLoadingState &&
        followState.orgId == widget.organizationss.organizationId;

   

    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: isLoading
            ? null
            : () async {
                final token =
                    await CacheHelper().getDataString(key: 'token');

                if (token == null || token.isEmpty) {
                  showLoginSheet(context); 
                  return;
                }

                final followCubit = context.read<FollowUnfollowCubit>();
                final orgCubit = context.read<OrganizertofollowCubit>();
                 final isCurrentlyFollowed = widget.organizationss.isFollowed ?? false;
                if (isCurrentlyFollowed) {
                  await followCubit.unfollowOrganization(
                      widget.organizationss.organizationId);
                  orgCubit.updateOrganizationFollowStatus(
                      widget.organizationss.organizationId, false);
                } else {
                  await followCubit.followOrganization(
                      widget.organizationss.organizationId);
                  orgCubit.updateOrganizationFollowStatus(
                      widget.organizationss.organizationId, true);
                }

                await context.read<GetorganizationidCubit>().fetchOrganizationById(
                      organizationId: widget.organizationss.organizationId,
                    );
              },
        child: Text(
          widget.organizationss.isFollowed==true?'Following':'Follow',
          style: TextStyle(
            color: widget.organizationss.isFollowed==true
            ?
            Colors.blue
            :
            Colors.blueGrey
            
          ),
          //isLoading
          /*
              ? 'Loading...'
              : (isCurrentlyFollowed ? 'Following' : 'Follow'),
          style: Styles.styleText16.copyWith(
            color: isCurrentlyFollowed
                ? const Color.fromARGB(159, 26, 26, 27)
                : Colors.blue,
          ),
          */
        ),
      ),
    );
  },
),

            ],
          ),
        ),
      ],
    );
  }
}
