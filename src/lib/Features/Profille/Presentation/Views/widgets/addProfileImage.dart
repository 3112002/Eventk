import 'dart:typed_data';
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Features/Profille/Presentation/Views/widgets/getProfileImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

/*Yara Adel*/
class ProfileImage extends StatefulWidget {
  final String? profilePictureUrl;
  final Uint8List? localImage;
  final Function(Uint8List, String)? onImageSelected;
  const ProfileImage(
      {super.key,
      this.profilePictureUrl,
      this.localImage,
      this.onImageSelected});
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  Uint8List? image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 65.sp,
          backgroundImage: Getprofileimage.getProfileImage(
              localImage: widget.localImage,
              profilePictureUrl: widget.profilePictureUrl,
              defaultAssetImage: AssestsImages.profileAvatar),
        ),
        Positioned(
          bottom: -9.h,
          left: 80.w,
          child: IconButton(
              onPressed: () async {
                final pickedFile = await ImagePicker()
                    .pickImage(source: ImageSource.gallery, imageQuality: 85);
                if (pickedFile != null) {
                  final bytes = await pickedFile.readAsBytes();
                  widget.onImageSelected?.call(bytes, pickedFile.path);
                  if (mounted) setState(() => image = bytes);
                  if (mounted) {
                    setState(() {
                      image = bytes;
                    });
                  }
                }
              },
              icon: Icon(
                Icons.add_a_photo_outlined,
                color: Colors.black,
                size: 25,
              )),
        )
      ],
    );
  }
}
