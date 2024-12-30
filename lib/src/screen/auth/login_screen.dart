import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/src.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String route = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController(text: kDebugMode ? "" : "");
  final SharedPreferencesService _sharedPrefs = SharedPreferencesService();

  final TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? "" : "");
  final formKey = GlobalKey<FormState>();
  bool showCrossIcon = false;
  bool showPassword = false;
  var loginState;

  @override
  void initState() {
    super.initState();
    loginState = context.read<LoginProvider>();

    emailController.addListener(() {
      setState(() {
        showCrossIcon = emailController.text.length >= 2;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // restrict users to press back or swipe to go back
      canPop: false,
      onPopInvoked: (value) async {
        doubleTapTrigger();
      },
      child: Scaffold(
        body: FutureBuilder(
          initialData: const [],
          future: Future.wait(
            [
              _sharedPrefs.getStringPref('settings'),
              _sharedPrefs.getStringPref('loggedUsers'),
              _sharedPrefs.getStringPref('server_key'),
              _sharedPrefs.getStringPref('server_value'),
            ],
          ),
          builder: (context, AsyncSnapshot snapshot) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 22),
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      image: DecorationImage(
                        image: AssetImage(Assets.pattern),
                        fit: BoxFit.cover,
                        opacity: 0.1,
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Gaps.verticalGapOf(50),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: CustomImage(
                              Assets.logo,
                              imageType: CustomImageType.local,
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Text("Hi, Wecome Back! 👋",
                                style: AppStyles.text20PxMedium
                                    .copyWith(color: const Color(0xFF506171))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Sign in to ",
                                    style: AppStyles.text14PxRegular.copyWith(
                                      color: AppColors.kPitchBlackColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Continue",
                                    style: AppStyles.text14PxRegular.copyWith(
                                      color: AppColors
                                          .kPrimaryColor, // Green color
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CustomTextField(
                            isRequired: true,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            prefix: SvgHelper.fromSource(
                                path: Assets.userprofile,
                                height: 20,
                                width: 20),
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            suffix: showCrossIcon
                                ? customInkwell(
                                    onTap: () {
                                      setState(() {
                                        emailController.clear();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                    ),
                                  )
                                : null,
                            hintText: "Email Address",
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: passwordController,
                            isRequired: true,
                            isObsecure:
                                !showPassword, // Toggles password visibility
                            prefix: SvgHelper.fromSource(
                                path: Assets.lock, height: 20, width: 20),
                            hintText: "Password",
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPassword =
                                      !showPassword; // Toggle password visibility
                                });
                              },
                              child: SvgHelper.fromSource(
                                  path: showPassword
                                      ? Assets.eye
                                      : Assets.eyeoff),
                            ),
                          ),
                          Gaps.verticalGapOf(10),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       // Forgot password logic here
                          //     },
                          //     child: customInkwell(
                          //       onTap: () {
                          //         Navigator.of(context).push(
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 const ForgotPasswordScreen(),
                          //           ),
                          //         );
                          //       },
                          //       child: Text(
                          //         "Forgot Password?",
                          //         style: Theme.of(context)
                          //             .textTheme
                          //             .bodyMedium!
                          //             .copyWith(
                          //                 color: AppColors.kPitchBlackColor),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Gaps.verticalGapOf(40),
                          CustomMaterialButton(
                            elevation: 0,
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                loginState.loginUser(
                                  context,
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            label: "Submit",
                          ),
                          // const Spacer(),
                          Gaps.verticalGapOf(20),
                          Text.rich(
                            TextSpan(
                              text: "Are you a new customer? ",
                              style: AppStyles.text14PxRegular.copyWith(
                                color: AppColors.kPitchBlackColor,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign up',
                                  style: AppStyles.text14PxRegular.copyWith(
                                    color: AppColors.kPrimaryColor,
                                    // decoration:
                                    //     TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Utility.navigate(
                                          context,
                                          '/register-screen',
                                        ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
