/*
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Features/Home/Presentation/Manager/organization_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/organization_state.dart';
import 'package:eventk/Features/Profille/Presentation/Views/widgets/organizationCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizerspageBody extends StatefulWidget {
  const OrganizerspageBody({super.key});

  @override
  State<OrganizerspageBody> createState() => _OrganizerspageBodyState();
}

class _OrganizerspageBodyState extends State<OrganizerspageBody> with SingleTickerProviderStateMixin 
    {
     
    
      
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    context.read<OrganizationCubit>().Organization(isFollowing: false);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      if (_tabController.index == 0) {
        context.read<OrganizationCubit>().Organization(isFollowing: false);
      } else if (_tabController.index == 1) {
        context.read<OrganizationCubit>().Organization(isFollowing: true);
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
              Tab(text: "Around You"),
              Tab(text: "Following"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Expanded(
  child: BlocConsumer<OrganizationCubit, OrganizationState>(
    listener: (context, state) {
      if (state is FailureOrganizationState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errMessage)),
        );
      }
    },
    builder: (context, state) {
      if (state is LoadingOrganizationState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is SuccessOrganizationState) {
        final organizations = state.organizationList;

        if (_tabController.index == 0) {
          // Around You
          if (organizations.isEmpty) {
            return const Center(child: Text("No organizers found around you."));
          } else {
            return ListView.builder(
              itemCount: organizations.length,
              itemBuilder: (context, index) {
                final organization = organizations[index];
                return Organizationcard(organization: organization);
              },
            );
          }
        } else {
          // Following
          final followedOrganizations =
              organizations.where((org) => org.isFollowed ?? false).toList();
          if (followedOrganizations.isEmpty) {
            return const Center(child: Text("No followed organizers yet."));
          } else {
            return ListView.builder(
              itemCount: followedOrganizations.length,
              itemBuilder: (context, index) {
                return Organizationcard(organization: followedOrganizations[index]);
              },
            );
          }
        }
      } else {
        return const Center(child: Text('Failed to load organizations'));
      }
    },
  ),
),
           
            
  
        ],
            ),
          ),
        ],
      )
  
      
      
    );
  }
    
}
*/
