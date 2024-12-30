import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class FMessageScreen extends StatefulWidget {
  static const String route = "/fmessage-screen";

  const FMessageScreen({super.key});

  @override
  State<FMessageScreen> createState() => _FMessageScreenState();
}

class _FMessageScreenState extends State<FMessageScreen> {
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
                Text('Check your mail',
                    style: AppStyles.text20PxMedium
                        .copyWith(color: AppColors.kPrimaryColor)),
                Gaps.verticalGapOf(10),
                Text(
                  'We have send a password recover instructions to your email.',
                  // textAlign: TextAlign.justify,
                  style: AppStyles.text12PxRegular.copyWith(
                      color: const Color.fromARGB(255, 108, 108, 108)),
                ),
                Gaps.verticalGapOf(40),
                CustomMaterialButton(
                    label: 'Open Email', fillButton: true, onTap: () {}),
                // Gaps.verticalGapOf(10),
                Center(
                  child: CustomTextButton(
                    text: "Skip, I'll confirm later.",
                    onPressed: () => Utility.navigate(
                      context,
                      '/resetpassword-screen',
                    ),
                    textStyle: AppStyles.text14PxMedium
                        .copyWith(color: AppColors.kPitchBlackColor),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
