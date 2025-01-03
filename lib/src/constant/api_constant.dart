class ApiConstant {
  // *********************** INSTANCE *********************** //
  static const String localUrl = 'http://192.168.1.80:8000';
  // static const String liveUrl = 'https://api.metalrecyclings.com';
  static const String liveUrl = 'https://smc.schost.me';

  // *********** Don't change anything below if you're not 1000% sure *********** //

  /// [AUTH_URL]
  static const String loginUri = '/login';
  static const String logoutUri = '/logout';
  static const String changePassword = '/reset-password';
  static const String registerUri = '/register';
  static const String verifyOtpUri = '/verify-otp';

  /// [URL]
  static const String profileUri = '/user';
  static const String configUri = '/config';

  /// [URL] --> [Pickup] Routes
  static const String pickUpRoutesUri = '/driver/route';
  static const String schedulePickUpRoutesUri = '/driver/schedule';

  /// [URL] --> [Delivery] Routes
  static const String deliveryRoutesUri = '/driver/trips';

  /// [URL] --> [Dashboard] Routes
  static const String dashboardUri = '/driver/dashboard';

  /// [URL] --> [twoFA] Routes
  static const String enable2FAUri = '/2fa/generate';
  static const String verify2FAUri = '/2fa/verify';
  static const String disable2FAUri = '/2fa/disable ';

  static const String notificationUri = '/notifications';
  static const String updateProfileUri = '/profile';
  static const String currentOrdersUri = '/current-orders';
  static const String orderDetailsUri = '/order-details';
  static const String orderHistoryUri = '/all-orders';
  static const String updateOrderStatusUri = '/update-order-status';
}
