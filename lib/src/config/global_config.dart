import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../src/src.dart';

class GlobalConfig {
  // App Settings
  static const String appName = AppConstants.appName;
  static const String appVersion = AppConstants.appVersion;
  static const bool defaultTheme = AppConstants.isDarkTheme;
  static const String defaultLang = AppConstants.defaultLanguage;

  // Debug
  static const bool isDebugMode = kDebugMode;
  static const bool isShowDebugModeBanner = false;

  // Colors
  static const Color primaryColor = AppColors.kPrimaryColor;

  // Environment
  static const Environment environment = Environment.production;

  //-***** Don't change unless you know 100% what you are doing *****-//

  // BASE URL
  static const String apiUrl = environment == Environment.local
      ? ApiConstant.localUrl
      : ApiConstant.liveUrl;

  static String baseUrl = '$apiUrl/api/v1';

  // // BASE URL
  // static Future<String> getBaseUrl() async {
  //   SharedPreferencesService prefs = SharedPreferencesService();
  //   String? selectedValue = await prefs.getStringPref('server_value');

  //   String apiUrl = environment == Environment.local
  //       ? ApiConstant.localUrl
  //       : selectedValue ??
  //           ApiConstant.liveUrl; // Fallback to default URL if no selection

  //   baseUrl = '$apiUrl/api/v1'; // Ensure correct concatenation
  //   return apiUrl;
  // }

  // Application ID
  static String applicationPackageId = AppConstants.applicationPackageId;

  // App username
  static const String appUsername = 'shikshya-teacher';

  /// App Website
  static const String appWebsite = 'https://shikshya.app';
  static const String privacyPolicyUrl =
      "https://www.shotcoder.com/shikshya-privacy-policy";
  static const String termsOfUseUrl =
      "https://www.shotcoder.com/shikshya-privacy-policy";

  static const String rateapp =
      'https://play.google.com/store/apps/details?id=com.migrationsns.consultancy_app';
}
