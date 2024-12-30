import 'package:flutter/material.dart';
import 'package:smc_flutter/src/screen/auth/forgotpassword/fmessage_screen.dart';
import 'package:smc_flutter/src/screen/auth/forgotpassword/resetpassword_screen.dart';
import 'package:smc_flutter/src/screen/auth/forgotpassword/success_screen.dart';
import 'package:smc_flutter/src/screen/auth/register_screen.dart';

import '../../src.dart';

class AppRoutes {
  static const String splashScreen =
      '/splash-screen'; // splash or initial route
  // static const String onboardingScreen = '/onboarding-screen';

  /// [Auth] Routes
  static const String loginScreen = '/login-screen';
  static const String registerScreen = '/register-screen';
  static const String logoutScreen = '/logout-screen';
  static const String forgotPasswordScreen = '/forgot-password';
  static const String twoFaScreenRoute = '/2fa-screen';
  static const String verificationScreenRoute = '/verification-screen';

  /// [Forgot Password] Routes
  static const String fPasswordScreen = '/fpassword-screen';
  static const String fMessageScreen = '/fmessage-screen';
  static const String resetPasswordScreen = '/resetpassword-screen';
  static const String successScreen = '/success-screen';

  /// [Dashboard] --> [Screens] Routes
  static const String dashboardScreen = '/dashboard-screen';
  static const String customerDashboardScreen = '/customer-dashboard-screen';
  static const String driverDashboardScreen = '/driver-dashboard-screen';
  static const String homeScreen = '/home-screen';
  static const String orderScreen = '/order-screen';
  static const String moreScreen = '/more-screen';
  static const String notificationScreen = '/notification-screen';

  /// [More]--> [Screen] Routes
  static const String settingsScreen = '/settings-screen';

  /// [More]--> [Settings]--> [Screens] Routes
  static const String updateProfileScreen = '/updateprofile-screen';
  static const String changePasswordScreen = '/changepassword-screen';
  static const String moreAlertScreen = '/morealert-screen';
  static const String languagePreferencesScreen = '/languagepreferences-screen';
  static const String contactSupportScreen = '/contactsupport-screen';
  static const String faqScreen = '/faq-screen';
  static const String themeScreen = '/theme-screen';

  static const String confirmationScreen = '/confirmation-screen';

  ///-----------------------------------------------------------------------///

  static Map<String, WidgetBuilder> routes = {
    /// [Splash] & [OnBoarding] Routes
    splashScreen: (context) => const SplashScreen(),
    // onboardingScreen: (context) => const OnBoardingScreen(),

    /// [Auth] Routes
    loginScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen(),
    logoutScreen: (context) => const LogoutScreen(),
    twoFaScreenRoute: (context) => const TwoFAScreen(),
    verificationScreenRoute: (context) => const VerificationScreen(),

    /// [Forgot Password] Routes
    fPasswordScreen: (context) => const ForgotPasswordScreen(),
    fMessageScreen: (context) => const FMessageScreen(),
    resetPasswordScreen: (context) => const ResetPasswordScreen(),
    successScreen: (context) => const SuccessScreen(),

    /// [Dashboard] --> [Screens] Routes
    dashboardScreen: (context) => const DashboardScreen(),
    driverDashboardScreen: (context) => const DriverDashboardScreen(),
    customerDashboardScreen: (context) => const CustomerDashboardScreen(),
    homeScreen: (context) => const HomeScreen(),
    orderScreen: (context) => const OrderScreen(),
    moreScreen: (context) => const MoreScreen(),
    notificationScreen: (context) => const NotificationScreen(),

    /// [More]--> [Screen] Routes
    settingsScreen: (context) => const SettingsScreen(),

    /// [More]--> [Settings]--> [Screens] Routes
    updateProfileScreen: (context) => const UpdateProfileScreen(),
    changePasswordScreen: (context) => const ChangePasswordScreen(),
    moreAlertScreen: (context) => const MoreAlertScreen(),
    languagePreferencesScreen: (context) => const ChangeLanguageScreen(),
    contactSupportScreen: (context) => const ContactSupportScreen(),
    faqScreen: (context) => const FAQScreen(),
    themeScreen: (context) => const ThemeScreen(),

    //----
    confirmationScreen: (context) => const ConfirmationScreen()
  };
}
