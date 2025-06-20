import 'package:eventk/Features/Organization/Presenation/manager/Cubits/organizerToFollow_cubit/organizerToFollow_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/organizerToFollow_cubit/organizerToFollow_states.dart';
import 'package:eventk/Features/Organization/Presenation/views/widgets/Organizationcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Followingbar extends StatelessWidget {
  const Followingbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizertofollowCubit, OrganizationsToFollowState>(
      builder: (context, state) {
        if (state is OrganizationsToFollowLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrganizationsToFollowFailureState) {
          return Center(
              child: Text(state.errorMessage,
                  style: TextStyle(color: Colors.black)));
          //Center(child: Text(state.errorMessage));
        } else if (state is OrganizationsToFollowSuccessState) {
          final organizations =
              state.organizations.where((org) => org.isFollowed!).toList();

          if (organizations.isEmpty) {
            return const Center(
                child: Text("You are not following any organizers.",
                    style: TextStyle(color: Colors.black)));
          }

          return ListView.builder(
            itemCount: organizations.length,
            itemBuilder: (context, index) {
              return Organizationcard(organization: organizations[index]);
            },
          );
        } else {
          return const Center(
              child: Text("Unexpected state",
                  style: TextStyle(color: Colors.black)));
        }
      },
    );
  }
}
