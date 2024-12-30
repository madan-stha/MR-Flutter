import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

import '../../navigator_key.dart';

class CustomToast {
  static void show(
    String msg, {
    Color? color,
    bool isSuccess = false,
    double? borderRadius,
    ToastLength? toastLength,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(
        navigatorKey.currentContext!); // Access ScaffoldMessenger directly

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: AppStyles.text12PxRegular,
          textAlign: TextAlign.left,
        ),
        duration: Utility.getDuration(toastLength),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? Dimensions.radiusDefault,
          ),
        ),
        animation: CurvedAnimation(
          parent: AnimationController(
            vsync: scaffoldMessenger,
            duration: const Duration(milliseconds: 500),
          ),
          curve: Curves.fastOutSlowIn,
        ),
        backgroundColor: color ??
            (isSuccess ? AppColors.kPrimaryColor : AppColors.warningColor),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
