import 'dart:typed_data';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/birthDateTextField.dart';
import 'package:eventk/Core/widgets/buttons.dart';
import 'package:eventk/Core/widgets/nameTextField.dart';
import 'package:eventk/Features/Profille/Data/models/profile_model.dart';
import 'package:eventk/Features/Profille/Presentation/Views/widgets/addProfileImage.dart';
import 'package:eventk/Features/Profille/Presentation/Views/widgets/bioTextField.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/profile_cubit/editProfile_cubit.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/profile_cubit/profile_cubit.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/profile_cubit/profile_state.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/*Yara❤️*/
class EditProfilePage extends StatefulWidget {
  final ProfileModel profile;
  const EditProfilePage({super.key, required this.profile});
  static String id = 'EditProfile';
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

/*Yara Adel Mohamed*/
class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  late TextEditingController nameController;
  late TextEditingController firstController;
  late TextEditingController lastController;
  late TextEditingController bioController;
  late TextEditingController birthdateController;
  Uint8List? _selectedImage;
  String? _imagePath;
/*Yara Adel Mohamed*/
  Future<void> _submitForm() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      if (_imagePath != null) {
        await context.read<EditprofileCubit>().editProfile(
            userName: nameController.text.isNotEmpty
                ? nameController.text
                : widget.profile.userName,
            firstName: firstController.text.isNotEmpty
                ? firstController.text
                : widget.profile.firstName,
            lastName: lastController.text.isNotEmpty
                ? lastController.text
                : widget.profile.lastName,
            bio: bioController.text.isNotEmpty
                ? bioController.text
                : widget.profile.bio ?? "",
            birthDate: birthdateController.text.isNotEmpty
                ? birthdateController.text
                : widget.profile.birthDate ?? "",
            profilePicturePath: _imagePath);
      } else {
        await context.read<EditprofileCubit>().editProfile(
              userName: nameController.text.isNotEmpty
                  ? nameController.text
                  : widget.profile.userName,
              firstName: firstController.text.isNotEmpty
                  ? firstController.text
                  : widget.profile.firstName,
              lastName: lastController.text.isNotEmpty
                  ? lastController.text
                  : widget.profile.lastName,
              bio: bioController.text.isNotEmpty
                  ? bioController.text
                  : widget.profile.bio ?? "",
              birthDate: birthdateController.text,
            );
      }
      if (mounted) {
        Navigator.pop(context);
        context.read<ProfileCubit>().fetchProfile();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.userName ?? '');
    firstController =
        TextEditingController(text: widget.profile.firstName ?? '');
    lastController = TextEditingController(text: widget.profile.lastName ?? '');
    bioController = TextEditingController(text: widget.profile.bio ?? '');
    birthdateController =
        TextEditingController(text: widget.profile.birthDate ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    firstController.dispose();
    lastController.dispose();
    bioController.dispose();
    birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: BlocListener<EditprofileCubit, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Profile updated successfully',
                ),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is EditProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kButtonsColor),
          ),
          child: Form(
            key: formKey,
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Edit your profile',
                      style: Styles.headingText40,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.h)),
                    ProfileImage(
                      profilePictureUrl: widget.profile.profilePic ?? " ",
                      localImage: _selectedImage,
                      onImageSelected: (bytes, path) {
                        setState(() {
                          _selectedImage = bytes;
                          _imagePath = path;
                        });
                      },
                    ),
                    NameTextField(
                      i: InputName(
                          label: 'User Name',
                          InitialValue: widget.profile.userName),
                      NameController: nameController,
                    ),
                    NameTextField(
                      i: InputName(
                          label: 'First Name',
                          InitialValue: widget.profile.firstName),
                      NameController: firstController,
                    ),
                    NameTextField(
                      i: InputName(
                          label: 'Last Name',
                          InitialValue: widget.profile.lastName),
                      NameController: lastController,
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.h)),
                    Biotextfield(BioCont: bioController),
                    BirthDateTextField(
                      birthdateController: birthdateController,
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.h)),
                    Buttons(
                      text: 'Edit',
                      onPressedCallBack: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
