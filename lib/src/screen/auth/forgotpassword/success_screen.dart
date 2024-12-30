import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class SuccessScreen extends StatefulWidget {
  static const String route = "/success-screen";

  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isBackButtonExist: true,
        onlyBackButton: true,
        bgColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Congratulations!',
                    style: AppStyles.text20PxMedium
                        .copyWith(color: AppColors.kPrimaryColor)),
                Gaps.verticalGapOf(10),
                Text(
                  'Your Password has been reset successfully. Now you can Signin with your new password.',
                  // textAlign: TextAlign.justify,
                  style: AppStyles.text12PxRegular.copyWith(
                      color: const Color.fromARGB(255, 108, 108, 108)),
                ),
                Gaps.verticalGapOf(40),
                CustomMaterialButton(
                  label: 'Sign In',
                  fillButton: true,
                  onTap: () => Utility.navigate(
                    context,
                    '/login-screen',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
