import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String route = "/fPasswordScreen";

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static final TextEditingController emailController =
      TextEditingController(text: "");
  bool showCrossIcon = false;
  static final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        showCrossIcon = emailController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isBackButtonExist: true,
        onlyBackButton: true,
        bgColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Forgot Password?',
                      style: AppStyles.text20PxMedium
                          .copyWith(color: AppColors.kPrimaryColor)),
                  Gaps.verticalGapOf(10),
                  Text(
                    'Enter your email associated with your count and we’ll send an email with instructions to reset your password.',
                    // textAlign: TextAlign.justify,
                    style: AppStyles.text12PxRegular.copyWith(
                        color: const Color.fromARGB(255, 108, 108, 108)),
                  ),
                  Gaps.verticalGapOf(20),
                  CustomTextField(
                    isRequired: true,
                    controller: emailController,
                    prefix: SvgHelper.fromSource(
                        path: Assets.email, height: 20, width: 20),
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
                    hintText: "Enter email address",
                  ),
                  const SizedBox(height: 30),
                  CustomMaterialButton(
                    label: 'Send',
                    fillButton: true,
                    onTap: () => Utility.navigate(
                      context,
                      '/fmessage-screen',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
