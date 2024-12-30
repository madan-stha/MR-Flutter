import 'dart:io';

import 'package:smc_flutter/src/src.dart';

class AppConstants {
  static const String appName = 'Metal Recycle';
  static const String appVersion = "v24.02.1.0";
  static const String fontFamily = 'Poppins';
  static const String defaultLanguage = 'en';

  // Theme
  static const bool isDarkTheme = false;

  // Shared Key
  static const String theme = 'theme';
  static const String token = 'token';
  static const String pickup = 'pickup';
  static const String delivery = 'delivery';
  static const String keyLangLtr = 'keyLangLtr';
  static const String keyAddressSelected = 'keyAddressSelected';

  // Location
  static const double demoLatitude = 27.6825008;
  static const double demoLongitude = 85.3435103;
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  // Tab
  static List tabList = [
    AppString.pickup,
    AppString.delivery,
  ];

  static List tableList = [
    AppString.material,
    AppString.amount,
  ];

  static List pickupTableList = [
    AppString.material,
    // AppString.amount,
    AppString.type,
    // AppString.weight
  ];

  static List<Map<String, String>> getStatusList = [
    {'key': 'active', 'value': 'Active'},
    {'key': 'inactive', 'value': 'In Active'},
    {'key': 'pending', 'value': 'Pending'},
    {'key': 'full', 'value': 'Full'},
    {'key': 'returning', 'value': 'Returning'},
    {'key': 'delayed', 'value': 'Delayed'},
    {'key': 'cancelled', 'value': 'Cancelled'},
  ];

  static List<Map<String, String>> getPickupStatusList = [
    {'key': 'active', 'value': 'Active'},
    {'key': 'inactive', 'value': 'In Active'},
    {'key': 'pending', 'value': 'Pending'},
    {'key': 'done', 'value': 'Done'},
    {'key': 'full', 'value': 'Full'},
    {'key': 'unloading', 'value': 'Unloading'},
    {'key': 'schedule', 'value': 'Schedule'},
    {'key': 'cancelled', 'value': 'Cancelled'},
  ];

  static List<String> serverKeys = [
    'SMC Server',
    'Laravel Server',
  ];

  static Map<String, String> serverMap = {
    'SMC Server': 'https://smc.schost.me',
    'Laravel Server': 'https://laravel.schost.me',
  };

  // status
  static const String active = 'active';
  static const String inProgress = 'in_progress';

  // Customer Url
  static const String customerUrl = 'https://metalrecyclings.com?mode=app';

  // Static Token
  static const String demoToken =
      '14|lJ5GqAq5bV101kQ9q0LA0nAw1m9wUM1e9dBFB7zx6cb545fe';
  static const String pusherApiKey = '3e521b9ee1d179669aaf';
  static const String pusherCluster = 'ap2';

  // Demo [Profile]
  static const String profileImage = 'https://i.ibb.co/jvj6MBw/lol.png';

  // Google Map
  static const String inAppMapUrl =
      'https://www.google.com/maps/dir/?api=1&origin=';
  static const String googleMapApiKey =
      'AIzaSyCkadS8MOAdp6VbKqAW4BH-VcZ7spxPjlE';
  static const String jwtToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcxNTc2NTU1MSwianRpIjoiYjhjOTc4YzUtMjE1My00YTBmLTg4MDItNGY1ZWI2MTg1NDg4IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjY1ZTc0ZTZjZTVmYTk3YjI1YzRhMGJiMyIsIm5iZiI6MTcxNTc2NTU1MSwiZXhwIjoxNzE1NzY3MzUxfQ.yRzIMXIoqE7QO8oztNqa_xszMwt0QVpcGbpp4WJuHgA';

  // Image Limit
  static const double limitOfPickedImageSizeInMB = 2;
  static const int limitOfPickedIdentityImageNumber = 2;
  static const double balanceInputLength = 10;

  static const int maximunPinCodeLength = 6;

  // Static [File] Path
  static const String languagePath = 'assets/i18n';

  /// Application ID
  static const String androidAppId = 'com.migrationsns.consultancy_app';
  static const String iosAppId = 'com.migrationsns.consultancy_app';
  static String applicationPackageId = Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=$androidAppId'
      : 'https://apps.apple.com/app/id=$iosAppId';

  /// Demo Login
  static const String demoLoginUsername = 'sid_sk.driver';
  static const String demoLoginPassword = '123456';
}
