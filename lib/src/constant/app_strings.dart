import 'package:easy_localization/easy_localization.dart';

class AppString {
  /// [Top & Bottom Navigation Bar]
  static const String home = 'Home';
  static const String order = 'Order';
  static const String profile = 'Profile';
  static const String notifications = 'Notifications';

  /// [More Screen] --> [Settings, Help, About, Logout]
  static const String settings = 'Settings';
  static const String help = 'Help & Support';
  static const String about = 'About Us';
  static const String logout = 'Logout';

  /// [Orders]
  static const String orderDetail = 'Order Details';
  static const String pickup = 'Pickup';
  static const String delivery = 'Delivery';

  /// [Materials] Information
  static const String material = 'Material';
  static const String amount = 'Weight';
  static const String rate = 'Rate';
  static const String type = 'Type';
  static const String weight = 'Weight';

  /// [Auth] --> [Session]
  static const String sessionExpired = 'Session Expired';
  static const String sessionExpiredMessage =
      'Your session has expired. Please login again.';
  static const String passwordChangeSuccess = "Password updated successfully.";

  /// [Order Status]
  static const String pendingStatus = 'Pending';
  static const String acceptedStatus = 'Accepted';
  static const String completedStatus = 'Completed';
  static const String canceledStatus = 'Canceled';
  static const String ongoingStatus = 'Ongoing';

  /// [Error Messages]
  static const String somethingWentWrong = 'Something went wrong';
  static const String internalServerError = 'Internal Server Error';
  static const String unknownError = 'Unknown Error';
  static const String noInternet = 'No Internet Connection';
  static const String noInternetMessage =
      'Please check your internet connection and try again.';

  /// [Permission Messages]
  static const String permission = 'Permission';
  static const String location = 'Location';
  static const String locationPermission = 'Location Permission';

  /// [Location Messages]
  static const String locationPermissionDenied =
      'You denied location permission. You need to allow permission to use this service.';
  static const String locationPermissionDeniedForever =
      'You denied location permission for forever. You need to allow permission to use this service.';
  static const String locationPermissionGranted = 'Location Permission Granted';

  /// [Alert Messages]
  static const String alert = 'Alert!';

  /// [Dialog Messages]
  static const String ok = 'Ok';
  static const String cancel = 'Cancel';
  static const String retry = 'Retry';
  static const String yes = 'Yes';
  static const String copy = 'Copy';
  static const String detail = 'Detail';

  /// [Dialog] --> [Logout]
  static const String logoutTitle = 'Taking a break?';
  static const String sureLogout = 'Are you sure you want to logout?';
  static const String logoutSuccess = 'Logout Success';
  static const String logoutFailed = 'Logout Failed';
  static const String yesLogout = 'Yes, Logout';

  /// [Language]
  /// [Translation] --> [Label]
  static String lblFullName = 'full_name'.tr();
  static String lblEmail = 'email'.tr();
  static String lblAddress = 'address'.tr();
  static String lblCity = 'city'.tr();
  static String lblState = 'state'.tr();
  static String lblCountry = 'country'.tr();
  static String lblDrInformation = 'driver_information'.tr();
  static String lblContactNumber = 'contact_no'.tr();
  static String lblSubmit = 'submit'.tr();
  static String lblEnterFullName = 'enter_full_name'.tr();
  static String lblEnterEmail = 'enter_email'.tr();
  static String lblEnterContactNumber = 'enter_contact_number'.tr();
  static String lblEnterAddress = 'enter_address'.tr();
  static String lblEnterCity = 'enter_city'.tr();
  static String lblEnterState = 'enter_state'.tr();
  static String lblEnterCountry = 'enter_country'.tr();
  static String lblEnterDrInformation = 'enter_dr_informatiiom'.tr();
  static String lblEnterCurrentPassword = 'enter_current_password'.tr();
  static String lblEnterNewPassword = 'enter_new_password'.tr();
  static String lblEnterConfirmationCode = 'enter_confirmation_code'.tr();
  static String lblEnterConfirmPassword = 'enter_confirm_password'.tr();
  static String lblCurrentPassword = 'current_password'.tr();
  static String lblNewPassword = 'new_password'.tr();
  static String lblConfirmNewPassword = 'confirm_new_password'.tr();
  static String lblPasswordChanged = 'password_changed'.tr();
  static String lblChangePassword = 'change_password'.tr();
  static String lblConfirmationCode = 'confirmation_code'.tr();
  static String lblSetup2FA = 'setup_2fa'.tr();
  static String lblEnable2FA = 'enable_2fa'.tr();
  static String lblTwoFaAuthentication = '2fa_authentication'.tr();
  static String lbl2FaInformation = '2fa_information'.tr();
  static String lbl2FaQrInformation = '2fa_qr_information'.tr();
  static String lbl2FaQrNotScan = '2fa_qr_not_scan'.tr();
  static String msg2FAConfirmation = '2fa_confirmation_msg'.tr();

  static String lblGetStarted = 'get_started'.tr();

  static String twoFaStep1 = "2fa_step1".tr();
  static String twoFaStep2 = "2fa_step2".tr();
  static String twoFaStep3 = "2fa_step3".tr();

  /// [Confirmation] --> [Label]
  static String confirmid = 'Confirm Task Id';
  static String taskid = 'Task #29292';
  static String confirmcustomername = 'Confirm Customer Name';
  static String customername = 'Siddhartha Shakya';
  static String confirmcustomercontact = 'Confirm Customer Contact';
  static String customercontact = '93838883';
  static String confirmcustomerlocation = 'Confirm Customer Location';
  static String customerlocation = 'Kapan, Kathmandu';

  /// [Language]
  /// [Translation] --> [Message]
  static String msgUpdatingPassword = 'updating_password'.tr();
  static String msgUpdatingProfile = 'updating_profile'.tr();
  static String msgStarting = 'starting'.tr();
  static String msgMarkingAsDone = 'marking_as_done'.tr();
  static String msgValidating2FA = 'validating_2fa'.tr();
  static String msgPasswordMissMatch = 'password_mismatch'.tr();
  static String msgPasswordChangedSuccessfully =
      'password_changed_successfully'.tr();
  static String msgProfileUpdatedSuccessfully =
      "profile_changed_successfully".tr();
  static String msg2FaValidatedSuccessfully =
      "two_fa_enabled_successfully".tr();
  static String msgNewPasswordShouldNotBeSameAsCurrentPassword =
      'new_password_should_not_be_same_as_current_password'.tr();
  static String msgPasswordMustBeMoreThan8 =
      'password_must_be_more_than_8_digit'.tr();
  static String msgPasswordDoesNotMatch = 'password_does_not_match'.tr();
  static String msgValidateEmptyField = 'validate_empty_field'.tr();
}
