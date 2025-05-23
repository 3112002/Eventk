import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/FailureScaffold.dart';
import 'package:eventk/Core/widgets/buttons.dart';
import 'package:eventk/Core/widgets/emailTextField.dart';
import 'package:eventk/Core/widgets/passwordTextField.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:eventk/Features/Profille/Presentation/Views/changePassword.dart';
import 'package:eventk/Features/Verification/Domain/ver_repo.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/ResetPasswordCubit/resetPassword_cubit.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/ResetPasswordCubit/resetPassword_state.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
TextEditingController emailController = TextEditingController();
bool isLoading = false;

/*Yara Adel*/
class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  static String id = 'ResetPassword';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ResetPasswordCubit(getIt<VerificationRepo>()),
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
          if (state is SuccessResetPasswordState) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          } else if (state is LoadingResetPasswordState) {
            isLoading = true;
          } else if (state is FailureResetPasswordState) {
            showFailureSnackBar(context, state.errorMessage);
            isLoading = false;
          }
        }, builder: (context, state) {
          return Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: isLoading!,
              progressIndicator: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kButtonsColor),
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
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 30.h)),
                          Text(
                            'Reset Password',
                            style: Styles.headingText40,
                          ),
                          Padding(padding: EdgeInsets.only(top: 40.h)),
                          Passwordtextfield(
                              passwordController: passwordController,
                              label: 'Password',
                              page: 'ResetPassword'),
                          Padding(padding: EdgeInsets.only(top: 30.h)),
                          Passwordtextfield(
                              passwordController: confirmPasswordController,
                              label: 'Confirm password',
                              page: 'ResetPassword'),
                          Padding(padding: EdgeInsets.only(top: 30.h)),
                          EmailTextField(
                              emailCotroller: emailController, label: 'Email'),
                          Padding(padding: EdgeInsets.only(top: 40.h)),
                          Buttons(
                              text: 'Reset Password',
                              onPressedCallBack: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<ResetPasswordCubit>(context)
                                      .ResetPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text);
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
