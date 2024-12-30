import 'package:flutter/material.dart';

import '../../src.dart';

ThemeData light = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: AppColors.kPrimaryColor,
  ),

  primaryColor: AppColors.kPrimaryColor, // for primary color
  fontFamily: AppConstants.fontFamily,
  secondaryHeaderColor: const Color(0xff04B200),
  brightness: Brightness.light,
  cardColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.backgroundcolor,
  focusColor: const Color(0xFFADC4C8),
  hintColor: const Color(0xFF52575C),
  shadowColor: Colors.grey[300],

  textTheme: TextTheme(
    displayLarge: const TextStyle(
        fontWeight: FontWeight.w300, fontSize: Dimensions.fontSizeDefault),
    displayMedium: const TextStyle(
        fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault),
    displaySmall: const TextStyle(
        fontWeight: FontWeight.w500, fontSize: Dimensions.fontSizeDefault),
    headlineMedium: const TextStyle(
        fontWeight: FontWeight.w600, fontSize: Dimensions.fontSizeDefault),
    headlineSmall: const TextStyle(
        fontWeight: FontWeight.w700, fontSize: Dimensions.fontSizeDefault),
    titleLarge: const TextStyle(
        fontWeight: FontWeight.w800, fontSize: Dimensions.fontSizeDefault),
    bodySmall: const TextStyle(
        fontWeight: FontWeight.w900, fontSize: Dimensions.fontSizeDefault),
    titleMedium: AppStyles.text16PxRegular.copyWith(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: AppStyles.text12PxRegular,
    bodyLarge: AppStyles.text16PxMedium,
  ),
).copyWith(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
