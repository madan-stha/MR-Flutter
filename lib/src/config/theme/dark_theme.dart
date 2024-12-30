import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

ThemeData dark = ThemeData(
  fontFamily: AppConstants.fontFamily,
  colorScheme: const ColorScheme.dark(),
  primaryColor: AppColors.kPrimaryColor, // for primary color
  brightness: Brightness.dark,
  cardColor: const Color(0xFF252525),
  hintColor: const Color(0xFFE7F6F8),
  focusColor: const Color(0xFFADC4C8),
  shadowColor: Colors.black.withOpacity(0.4),
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
