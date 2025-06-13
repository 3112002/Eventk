import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/utils/assests.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/FailureScaffold.dart';
import 'package:eventk/Core/widgets/buttons.dart';
import 'package:eventk/Core/widgets/buttonsText.dart';
import 'package:eventk/Core/widgets/navigationHome.dart';
import 'package:eventk/Core/widgets/passwordTextField.dart';
import 'package:eventk/Core/widgets/userNameTextField.dart';
import 'package:eventk/Features/Authentication/Domain/Auth_repo.dart';
import 'package:eventk/Features/Authentication/Presentation/Manager/Login_Cubit.dart';
import 'package:eventk/Features/Authentication/Data/Model/Login_Model.dart';
import 'package:eventk/Features/Authentication/Presentation/Manager/Login_State.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/widgets/haveAccount.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/widgets/skipButton.dart';
import 'package:eventk/Features/Verification/Presentation/Views/forgetPassword.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/*Yara Adel*/
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

LoginModel? loginModel;
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt<AuthRepo>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            //Navigate to Home screen
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationHomePage(),
                ));
          } else if (state is FailarLoginState) {
            showFailureSnackBar(context, state.errorMessage);
            isLoading = false;
          } else if (state is LoadingLoginState) {
            isLoading = true;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(children: [
              ModalProgressHUD(
                inAsyncCall: isLoading!,
                progressIndicator: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kButtonsColor),
                ),
                child: Form(
                  key: formKey,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 60.h)),
                          Container(
                            child: Image.asset(
                              AssestsImages.logo,
                              width: 160.w,
                              height: 160.h,
                            ),
                          ),
                          Text(
                            'Login',
                            style: Styles.headingText40,
                          ),
                          //Padding(padding: EdgeInsets.only(top: 40.h)),
                          UserNameTextField(
                              emailCotroller: emailController,
                              label: 'Email or username'),
                          Passwordtextfield(
                            passwordController: passwordController,
                            label: 'Password',
                            page: 'Login',
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.h)),
                          ButtonsText(
                            text: 'Forget password ?',
                            onPressedCallBack: () =>
                                Navigator.pushNamed(context, ForgetPassword.id),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.h)),
                          Buttons(
                            text: 'Login',
                            onPressedCallBack: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).Login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          HaveAccount(have: 'Don\'t have', page: 'Signup'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Skipbutton()
            ]),
          );
        },
      ),
    );
  }
}
