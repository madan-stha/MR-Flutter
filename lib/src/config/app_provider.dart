import 'package:provider/provider.dart';
import 'package:smc_flutter/src/provider/signup_provider.dart';
import 'package:smc_flutter/src/provider/verify_otp_provider.dart';
import 'package:smc_flutter/src/src.dart';

class AppProvider {
  static final themeProvider = ThemeProvider(
    sharedPreferences: null,
  );

  static final loginProvider = LoginProvider();
  static final signupProvider = SignupProvider();
  static final verifyOtpProvider = VerifyOtpProvider();
  static final authProvider = AuthProvider();
  static final twoFaProvider = TwoFaProvider();
  static final homeProvider = HomeProvider();
  static final userProvider = UserProvider();
  static final languageProvider = LanguageProvider();

  static final pickUpProvider = PickUpProvider();
  static final pickUpDetailProvider = ProutesDetailProvider();
  static final deliveryProvider = DeliveryProvider();
  static final deliveryDetailProvider = DeliveryDetailProvider();
  static final notificationProvider = NotificationProvider();
  static final locationProvider = LocationProvider();
  static final sessionProvider = SessionProvider();

  static final List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => themeProvider,
    ),
    ChangeNotifierProvider<LoginProvider>(
      create: (context) => loginProvider,
    ),
    ChangeNotifierProvider<SignupProvider>(
      create: (context) => signupProvider,
    ),
 ChangeNotifierProvider<VerifyOtpProvider>(
      create: (context) => verifyOtpProvider,
    ),
    ChangeNotifierProvider<HomeProvider>(
      create: (context) => homeProvider,
    ),
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => authProvider,
    ),
    ChangeNotifierProvider<TwoFaProvider>(
      create: (context) => twoFaProvider,
    ),
    ChangeNotifierProvider<UserProvider>(
      create: (context) => userProvider..fetchData(),
    ),
    ChangeNotifierProvider<LanguageProvider>(
      create: (context) => languageProvider,
    ),
    ChangeNotifierProvider<PickUpProvider>(
      create: (context) => pickUpProvider..fetchData(),
    ),
    ChangeNotifierProvider<ProutesDetailProvider>(
      create: (context) => pickUpDetailProvider,
    ),
    ChangeNotifierProvider<DeliveryProvider>(
      create: (context) => deliveryProvider..fetchData(),
    ),
    ChangeNotifierProvider<DeliveryDetailProvider>(
      create: (context) => deliveryDetailProvider,
    ),
    ChangeNotifierProvider<NotificationProvider>(
      create: (context) => notificationProvider..fetchData(),
    ),
    ChangeNotifierProvider<LocationProvider>(
      create: (context) => locationProvider,
    ),
    ChangeNotifierProvider<SessionProvider>(
      create: (context) => sessionProvider,
    ),
  ];

  static void dispose() {
    themeProvider.dispose();
    loginProvider.dispose();
    authProvider.dispose();
    twoFaProvider.dispose();

    homeProvider.dispose();
    userProvider.dispose();
    languageProvider.dispose();

    pickUpProvider.dispose();
    pickUpDetailProvider.dispose();
    deliveryProvider.dispose();
    deliveryDetailProvider.dispose();
    notificationProvider.dispose();

    locationProvider.dispose();
  }

  /// Singleton factory
  static final AppProvider _instance = AppProvider._internal();

  factory AppProvider() {
    return _instance;
  }

  AppProvider._internal();
}
