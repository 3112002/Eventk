import 'package:eventk/Features/Organization/Data/repos/OrganizationRepo_Impl.dart';
import 'package:eventk/Features/Organization/Presenation/manager/Cubits/organizerToFollow_cubit/organizerToFollow_cubit.dart';
import 'package:eventk/Features/Organization/Presenation/views/widgets/OrganizersToFollow_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Organizerstofollow extends StatelessWidget {
  const Organizerstofollow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OrganizertofollowCubit(OrganizationrepoImpl())
          ..fetchOrganizationsToFollow(isFollowing: false),
        child: OrganizerspageBody());
  }
}
