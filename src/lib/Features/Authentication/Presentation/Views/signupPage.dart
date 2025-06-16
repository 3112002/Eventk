import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/birthDateTextField.dart';
import 'package:eventk/Core/widgets/buttons.dart';
import 'package:eventk/Core/widgets/emailTextField.dart';
import 'package:eventk/Core/widgets/nameTextField.dart';
import 'package:eventk/Core/widgets/passwordTextField.dart';
import 'package:eventk/Features/Authentication/Domain/Auth_repo.dart';
import 'package:eventk/Features/Authentication/Presentation/Manager/SignUp_Cubit.dart';
import 'package:eventk/Features/Authentication/Presentation/Manager/SignUp_State.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/widgets/haveAccount.dart';
import 'package:eventk/Features/Verification/Presentation/Views/verificationPage.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/*Yara❤️*/

// ignore: must_be_immutable
class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  static String id = 'SignupPage';
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final InputName userNameInput =
      InputName(label: 'User Name', InitialValue: '');
  final InputName firstNameInput =
      InputName(label: 'First Name', InitialValue: '');
  final InputName lastNameInput =
      InputName(label: 'Last Name', InitialValue: '');
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<AuthRepo>()),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SuccessSignupState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VerificationPage('Signup'),
                ));
          } else if (state is FailureSignupState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(' Email is alerady exit'),
              backgroundColor: Colors.red,
            ));
            isLoading = false;
          } else if (state is LoadingSignupState) {
            isLoading = true;
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            progressIndicator: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kButtonsColor),
            ),
            child: Form(
              key: formKey,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: kPrimaryColor,
                ),
                body: SizedBox(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.h)),
                        Text(
                          'Signup',
                          style: Styles.headingText40,
                        ),
                        NameTextField(
                            i: userNameInput,
                            NameController: userNameController),
                        NameTextField(
                            i: firstNameInput,
                            NameController: firstNameController),
                        NameTextField(
                            i: lastNameInput,
                            NameController: lastNameController),
                        Padding(padding: EdgeInsets.only(top: 30.h)),
                        EmailTextField(
                            emailCotroller: emailController, label: 'Email'),
                        Padding(padding: EdgeInsets.only(top: 15.h)),
                        BirthDateTextField(
                          birthdateController: birthdateController,
                        ),
                        Padding(padding: EdgeInsets.only(top: 30.h)),
                        Passwordtextfield(
                            passwordController: passwordController,
                            label: 'Password',
                            page: 'Signup'),
                        Padding(padding: EdgeInsets.only(top: 30.h)),
                        Buttons(
                          text: 'Register',
                          onPressedCallBack: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<SignupCubit>(context).SignUp(
                                  userName: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  birthDate: birthdateController.text);
                            }
                          },
                        ),
                        HaveAccount(have: 'Have', page: 'Login'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
