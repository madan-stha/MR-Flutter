import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPreferencesService _sharedPref = SharedPreferencesService();

  @override
  void initState() {
    super.initState();

    onNavigate();
  }

  onNavigate() async {
    var data = await _sharedPref.getStringPref('userData');
    bool logged = await _sharedPref.getBoolPref('logged');
    if (!mounted) return;
    Timer(
      const Duration(seconds: 3),
      () async {
        (logged && data != null)
            ? Utility.navigate(
                context,
                AppRoutes.dashboardScreen,
              )
            : Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreen,
                (route) => false,
              );
      },
    );
  }

  // void navigate() async {
  //   bool firstLogin = await _sharedPref.getBoolPref('firstLogin');
  //   // var data = await _sharedPref.getStringPref('userData');
  //   // bool isDriver = await data['role'] == "" || data['role'] == null
  //   //     ? false
  //   //     : data['role'] == 'driver'
  //   //         ? true
  //   //         : false;

  //   if (!mounted) return;
  //   Timer(
  //     const Duration(seconds: 3),
  //     () async {
  //       if (!firstLogin) {
  //         await _sharedPref.setStringPref(
  //           'settings',
  //           {
  //             'biometric': true,
  //           },
  //         );
  //         await _sharedPref.setBoolPref('firstLogin', true);
  //         if (!mounted) return;
  //         Utility.navigate(context, '/onboarding-screen');
  //       } else {
  //         Utility.navigate(context, '/login-screen');
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 75.0,
            vertical: 15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              CustomImage(
                Assets.logo,
                imageType: CustomImageType.local,
                height: 200,
                width: double.infinity,
              ),
              const Spacer(),
              Text(
                "Proudly Powered By:",
                style:
                    AppStyles.text10PxRegular.copyWith(color: AppColors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              // SvgHelper.fromSource(
              //   path: Assets.poweredBy,
              //   height: 15,
              // ),
              SizedBox(
                height: 28,
                width: 150,
                child: CustomImage(
                  Assets.companyLogo,
                  imageType: CustomImageType.local,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
