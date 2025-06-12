import 'package:dio/dio.dart';
import 'package:eventk/Core/utils/delete_profile_service.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/buttons.dart';
import 'package:eventk/Core/widgets/passwordTextField.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:eventk/Features/Profille/Presentation/Views/widgets/showDialog.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/deleteProfile_cubit/deleteProfile_cubit.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/deleteProfile_cubit/deleteProfile_state.dart';
import 'package:eventk/constants.dart';
import 'package:eventk/helper/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara❤️*/
class DeleteProfile extends StatelessWidget {
  const DeleteProfile({super.key});
  static String id = 'DeleteProfile';
/*Yara Adel Mohamed*/
  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => DeleteprofileCubit(
        service: DeleteProfileService(api: Api(dio: Dio())),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('Delete Profile'),
        ),
        body: Form(
          key: formKey,
          child: BlocConsumer<DeleteprofileCubit, DeleteprofileStates>(
            listener: (context, state) {
              if (state is DeleteProfileSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Profile deleted successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginPage.id,
                  (route) => false,
                );
              } else if (state is DeleteProfileFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      'Delete Profile',
                      style: Styles.headingText40,
                    ),
                    SizedBox(height: 60.h),
                    Passwordtextfield(
                      passwordController: passwordController,
                      label: 'Current Password',
                      page: 'DeleteProfile',
                    ),
                    SizedBox(height: 50.h),
                    if (state is DeleteProfileLoadingState)
                      const CircularProgressIndicator()
                    else
                      Buttons(
                        text: "Delete Profile",
                        onPressedCallBack: () {
                          if (formKey.currentState!.validate()) {
                            ShowDialog(
                                context: context,
                                password: passwordController.text);
                          }
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
