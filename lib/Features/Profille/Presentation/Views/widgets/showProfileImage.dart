import 'dart:typed_data' as typed_data;

import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Features/Profille/Presentation/Views/widgets/getProfileImage.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/deleteProfilePic_cubit/deleteProfilePic_states';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/profile_cubit/profile_cubit.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/deleteProfilePic_cubit/deleteProfilePic_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*Yara Adel Mohamed*/
class Showprofileimage extends StatefulWidget {
  final String? profilePictureUrl;
  final typed_data.Uint8List? localImage;

  const Showprofileimage(
      {super.key, required this.profilePictureUrl, this.localImage});

  @override
  State<Showprofileimage> createState() => _ShowprofileimageState();
}

class _ShowprofileimageState extends State<Showprofileimage> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 75,
      left: MediaQuery.of(context).size.width / 2 - 60,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: Getprofileimage.getProfileImage(
                localImage: widget.localImage,
                profilePictureUrl: widget.profilePictureUrl,
                defaultAssetImage: AssestsImages.profileAvatar),
          ),
          BlocConsumer<DeleteprofilepicCubit, DeleteprofilepicStates>(
            listener: (context, state) {
              if (state is DeleteProfilePicSuccessState) {
                //show message
                context.read<ProfileCubit>().fetchProfile();
              } else if (state is DeleteProfilePicFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(7),
                child: InkWell(
                  onTap: () {
                    context.read<DeleteprofilepicCubit>().deletePrfilePic();
                  },
                  child: state is DeleteProfilePicLoadingState
                      ? SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(
                          Icons.remove,
                          color: Colors.red.shade400,
                          size: 15,
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
