import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/FailureScaffold.dart';
import 'package:eventk/Core/widgets/buttons.dart';
import 'package:eventk/Core/widgets/emailTextField.dart';
import 'package:eventk/Features/Verification/Domain/ver_repo.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/ForgetPasswordCubit/forgetPassword_cubit.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/ForgetPasswordCubit/forgetPassword_state.dart';
import 'package:eventk/Features/Verification/Presentation/Views/Widgets/verificationPageForgotPassword.dart';
import 'package:eventk/Features/Verification/Presentation/Views/verificationPage.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/*Yara Adel*/
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey();

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  static String id = 'ForgetPassword';

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return BlocProvider(
        create: (context) => ForgetpasswordCubit(getIt<VerificationRepo>()),
        child: BlocConsumer<ForgetpasswordCubit, ForgetpasswordState>(
            listener: (context, state) {
          if (state is SuccessForgetPasswordState) {
            isLoading = false;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificationPage('ForgetPassword')));
          } else if (state is LoadingForgetPasswordState) {
            isLoading = true;
          } else if (state is FailureForgetPasswordState) {
            isLoading = false;
            showFailureSnackBar(context, state.errMessage);
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
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 30.h)),
                          Text(
                            'Forget Password',
                            style: Styles.headingText40,
                          ),
                          Padding(padding: EdgeInsets.only(top: 60.h)),
                          EmailTextField(
                              emailCotroller: emailController, label: 'Email'),
                          Padding(padding: EdgeInsets.only(top: 30.h)),
                          Buttons(
                              text: 'Confirm',
                              onPressedCallBack: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<ForgetpasswordCubit>(context)
                                      .ForgetEmail(email: emailController.text);
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
