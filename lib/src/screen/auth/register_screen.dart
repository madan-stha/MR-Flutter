import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smc_flutter/src/provider/signup_provider.dart';
import 'package:smc_flutter/src/screen/auth/verify_otp_screen.dart';
import 'package:smc_flutter/src/src.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static final TextEditingController usernameController =
      TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  static final TextEditingController confirmpasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showUsernameCrossIcon = false;
  bool showEmailCrossIcon = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(_onUsernameChanged);
    emailController.addListener(_onEmailChanged);
  }

  void _onUsernameChanged() {
    setState(() {
      showUsernameCrossIcon = usernameController.text.isNotEmpty;
    });
  }

  void _onEmailChanged() {
    setState(() {
      showEmailCrossIcon = emailController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    usernameController.removeListener(_onUsernameChanged);
    emailController.removeListener(_onEmailChanged);
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  image: DecorationImage(
                    image: AssetImage(Assets.pattern),
                    fit: BoxFit.cover,
                    opacity: 0.1,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 60),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          "Let's Get Started",
                          style: AppStyles.text20PxMedium
                              .copyWith(color: const Color(0xFF506171)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Register as ",
                                style: AppStyles.text14PxRegular.copyWith(
                                  color: AppColors.kPitchBlackColor,
                                ),
                              ),
                              TextSpan(
                                text: "Customer",
                                style: AppStyles.text14PxRegular.copyWith(
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomTextField(
                        isRequired: true,
                        controller: usernameController,
                        textInputAction: TextInputAction.next,
                        prefix: SvgHelper.fromSource(
                            path: Assets.userprofile, height: 20, width: 20),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        },
                        suffix: showUsernameCrossIcon
                            ? customInkwell(
                                onTap: () {
                                  setState(() {
                                    usernameController.clear();
                                  });
                                },
                                child: const Icon(Icons.clear),
                              )
                            : null,
                        hintText: "Username",
                        labelText: "Enter your username",
                      ),
                      Gaps.verticalGapOf(20),
                      CustomTextField(
                        isRequired: true,
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        prefix: SvgHelper.fromSource(
                            path: Assets.email, height: 20, width: 20),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                        suffix: showEmailCrossIcon
                            ? customInkwell(
                                onTap: () {
                                  setState(() {
                                    emailController.clear();
                                  });
                                },
                                child: const Icon(Icons.clear),
                              )
                            : null,
                        hintText: "Email Address",
                        labelText: "Enter your email address",
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: passwordController,
                        isRequired: true,
                        isObsecure: !showPassword,
                        prefix: SvgHelper.fromSource(
                            path: Assets.lock, height: 20, width: 20),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          // Check for at least one uppercase letter
                          if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                            return 'Password must contain at least one uppercase letter';
                          }
                          // Check for at least one special character
                          if (!RegExp(r'(?=.*[!@#\$&*~])').hasMatch(value)) {
                            return 'Password must contain at least one special character';
                          }
                          // Check for minimum length requirement
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                        hintText: "Password",
                        labelText: "Enter your password",
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: SvgHelper.fromSource(
                              path: showPassword ? Assets.eye : Assets.eyeoff),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: confirmpasswordController,
                        isRequired: true,
                        isObsecure: !showConfirmPassword,
                        prefix: SvgHelper.fromSource(
                            path: Assets.lock, height: 20, width: 20),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        hintText: "Confirm Password",
                        labelText: "Enter to confirm password",
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
                          child: SvgHelper.fromSource(
                              path: showConfirmPassword
                                  ? Assets.eye
                                  : Assets.eyeoff),
                        ),
                      ),
                      Gaps.verticalGapOf(30),
                      CustomMaterialButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await context.read<SignupProvider>().signupUser(
                                  context,
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  confirmpasswordController.text,
                                );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerifyOtpScreen(
                                    email: emailController.text),
                              ),
                            );
                          }
                        },
                        label: "Submit",
                      ),
                      Gaps.verticalGapOf(10),
                      Text.rich(
                        TextSpan(
                          text: 'Already have a customer account? ',
                          style: AppStyles.text12PxRegular
                              .copyWith(color: AppColors.kPitchBlackColor),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.kPrimaryColor,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      Gaps.verticalGapOf(15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
