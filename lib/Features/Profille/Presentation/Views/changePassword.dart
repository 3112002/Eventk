import 'package:dio/dio.dart';
import 'package:eventk/Core/utils/change_password_service.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/buttons.dart';
import 'package:eventk/Core/widgets/passwordTextField.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/changePass_cubit/changePass_cubit.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/changePass_cubit/changePass_state.dart';
import 'package:eventk/constants.dart';
import 'package:eventk/helper/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Yara❤️*/

TextEditingController oldPasswordController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();
TextEditingController confirmNewPasswordController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey();

/*Yara Adel*/
/*Yara Adel Mohamed*/
class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});
  static String id = 'ChangePassword';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangepasswordCubit>(
      create: (context) => ChangepasswordCubit(
        service: ChangepasswordService(api: Api(dio: Dio())),
      ),
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
          ),
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: BlocConsumer<ChangepasswordCubit, ChangepasswordStates>(
                listener: (context, state) {
                  if (state is ChangePasswordSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Password Changed Successfully')),
                    );
                    Navigator.pop(context);
                  } else if (state is ChangePasswordFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)));
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20.h)),
                      Text(
                        'Change Password',
                        style: Styles.headingText40,
                      ),
                      Padding(padding: EdgeInsets.only(top: 60.h)),
                      Passwordtextfield(
                        passwordController: oldPasswordController,
                        label: 'Old password',
                        page: 'ChangePassword',
                      ),
                      Padding(padding: EdgeInsets.only(top: 40.h)),
                      Passwordtextfield(
                        passwordController: newPasswordController,
                        label: 'New password',
                        page: 'ChangePassword',
                      ),
                      Padding(padding: EdgeInsets.only(top: 40.h)),
                      Passwordtextfield(
                        passwordController: confirmNewPasswordController,
                        label: 'Confirm password',
                        page: 'ChangePassword',
                      ),
                      SizedBox(height: 50.h),
                      if (state is ChangepasswordLoadingState)
                        const CircularProgressIndicator()
                      else
                        Buttons(
                          text: "Change Password",
                          onPressedCallBack: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<ChangepasswordCubit>(context)
                                  .changePass(
                                oldPasswordController.text,
                                newPasswordController.text,
                                confirmNewPasswordController.text,
                              );
                            }
                          },
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
