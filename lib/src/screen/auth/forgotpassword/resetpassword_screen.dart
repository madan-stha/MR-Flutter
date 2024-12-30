import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';


class ResetPasswordScreen extends StatefulWidget {
  static const String route = "/fPasswordScreen";

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  static final TextEditingController newPasswordController =
      TextEditingController(text: "");
  static final TextEditingController confirmnewPasswordController =
      TextEditingController(text: "");

  bool showPassword = false;
  bool showConfirmPassword = false;

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isBackButtonExist: true,
        onlyBackButton: true,
        bgColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create New Password',
                        style: AppStyles.text20PxMedium
                            .copyWith(color: AppColors.kPrimaryColor)),
                    Gaps.verticalGapOf(10),
                    Text(
                      'Your new password must be different from previous password.',
                      // textAlign: TextAlign.justify,
                      style: AppStyles.text12PxRegular.copyWith(
                          color: const Color.fromARGB(255, 108, 108, 108)),
                    ),
                    Gaps.verticalGapOf(30),
                    CustomTextField(
                      controller: newPasswordController,
                      isRequired: true,
                      isObsecure: !showPassword,
                      prefix: SvgHelper.fromSource(
                          path: Assets.lock, height: 20, width: 20),
                      hintText: "New Password",
                      labelText: "Enter new password",
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
                    Gaps.verticalGapOf(20),
                    CustomTextField(
                      controller: confirmnewPasswordController,
                      isRequired: true,
                      isObsecure: !showConfirmPassword,
                      prefix: SvgHelper.fromSource(
                          path: Assets.lock, height: 20, width: 20),
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
                      onTap: () => Utility.navigate(
                        context,
                        '/success-screen',
                      ),
                      label: "Reset Password",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
