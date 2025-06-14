import 'dart:async';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/FailureScaffold.dart';
import 'package:eventk/Core/widgets/buttons.dart';
import 'package:eventk/Features/Authentication/Domain/Auth_repo.dart';
import 'package:eventk/Features/Authentication/Presentation/Manager/SignUp_Cubit.dart';
import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:eventk/Features/Verification/Domain/ver_repo.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/ConfirmEmailCubit/confirmEmail_cubit.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/ConfirmEmailCubit/confirmEmail_state.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/VerifyEmailCubit/verifyEmail_cubit.dart';
import 'package:eventk/Features/Verification/Presentation/Manager/VerifyEmailCubit/verifyEmail_state.dart';
import 'package:eventk/Features/Verification/Presentation/Views/Widgets/boxText.dart';
import 'package:eventk/Features/Verification/Presentation/Views/Widgets/verText.dart';
import 'package:eventk/Features/Verification/Presentation/Views/resetPassword.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/*Yara Adel Mohamed El-sayed*/
int resend = 30;
late Timer _timer;
bool showResendButton = false;

class VerificationPage extends StatefulWidget {
  VerificationPage(this.comeFrom);
  final String comeFrom;
  @override
  State<VerificationPage> createState() => _VerificationState();
}

class _VerificationState extends State<VerificationPage> {
  static String id = 'VerificationPage';
  @override
  void initState() {
    super.initState();
    otpController.clear();

    StartTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    otpController.dispose();
    emailController.dispose();
    super.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ConfirmemailCubit(getIt<VerificationRepo>()),
          ),
          BlocProvider(
            create: (context) => SignupCubit(getIt<AuthRepo>()),
          ),
          BlocProvider(
            create: (context) => VerifyEmailCubit(getIt<VerificationRepo>()),
          ),
        ],
        child: widget.comeFrom == 'ForgetPassword'
            ? blocConsumerVerifyEmail(context)
            : blocConsumerConfirmEmail(context));
  }

  Widget blocConsumerConfirmEmail(BuildContext context) {
    return BlocConsumer<ConfirmemailCubit, ConfirmEmailState>(
      listener: (context, state) {
        if (state is LoadingStateConfirmEmail) {
          isLoading = true;
        } else if (state is FailureStateConfirmEmail) {
          showFailureSnackBar(context, state.errMeassage);
          isLoading = false;
        } else if (state is SuccessStateConfirmEmail) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        }
      },
      builder: (context, state) {
        return verificationBody(context);
      },
    );
  }

  Widget blocConsumerVerifyEmail(BuildContext context) {
    return BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
      listener: (context, state) {
        if (state is LoadingVerifyEmailState) {
          isLoading = true;
        } else if (state is FailureVerifyEmailState) {
          showFailureSnackBar(context, state.errMessage);
          isLoading = false;
        } else if (state is SuccessVerifyEmailState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPassword(),
              ));
        }
      },
      builder: (context, state) {
        return verificationBody(context);
      },
    );
  }

  Widget verificationBody(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 80.h)),
                    Text(
                      'Verification',
                      style: Styles.headingText40,
                    ),
                    Padding(padding: EdgeInsets.only(top: 50.h)),
                    EmailText(comeFrom: widget.comeFrom),
                    FittedBoxText(),
                    Padding(padding: EdgeInsets.only(top: 30.h)),
                    Buttons(
                      text: 'Countione',
                      onPressedCallBack: () async {
                        if (formKey.currentState!.validate()) {
                          saveOtp();
                          if (widget.comeFrom == 'ForgetPassword') {
                            BlocProvider.of<VerifyEmailCubit>(context)
                                .VerifyEmail(
                                    email:
                                        getIt<CacheHelper>()
                                            .getData(key: 'forgetEmail'),
                                    otp: getIt<CacheHelper>()
                                        .getData(key: 'otp'));
                          } else {
                            BlocProvider.of<ConfirmemailCubit>(context)
                                .ConfirmEmail(
                                    email: getIt<CacheHelper>()
                                        .getData(key: 'email'),
                                    otp: getIt<CacheHelper>()
                                        .getData(key: 'otp'));
                          }
                        }
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.h)),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Re-send code in ",
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text(
                            '00:',
                            style: TextStyle(color: kButtonsColor),
                          ),
                          if (resend < 10)
                            const Text(
                              '0',
                              style: TextStyle(color: kButtonsColor),
                            ),
                          Padding(padding: EdgeInsets.only(top: 10.h)),
                          Text(
                            '$resend',
                            style: TextStyle(color: kButtonsColor),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.h)),
                    TextButton(
                        onPressed: () async {
                          if (resend == 0) {
                            BlocProvider.of<SignupCubit>(context).SignUp(
                                userName: getIt<CacheHelper>()
                                    .getData(key: 'userName'),
                                email:
                                    getIt<CacheHelper>().getData(key: 'email'),
                                password: getIt<CacheHelper>()
                                    .getData(key: 'password'),
                                firstName: getIt<CacheHelper>()
                                    .getData(key: 'firstName'),
                                lastName: getIt<CacheHelper>()
                                    .getData(key: 'lastName'),
                                birthDate: getIt<CacheHelper>()
                                    .getData(key: 'birthDate'));

                            setState(() {
                              resend = 30;
                              StartTimer();
                            });
                          }
                        },
                        child: Text(
                          'Resend',
                          style:
                              Styles.styleText20.copyWith(color: kButtonsColor),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void StartTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      if (resend == 0) {
        setState(() {
          showResendButton = true;
          timer.cancel();
        });
      } else {
        setState(() {
          resend -= 1;
        });
      }
    });
  }
}
