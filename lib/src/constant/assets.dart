class Assets {
  static String get logo => 'logo'.png;
  static String get mainLogo => 'app_logo'.png;
  static String get placeholder => 'placeholder'.png;
  static String get companyLogo => 'company_logo'.png;

  /// [Svg] Logo
  static String get poweredBy => 'powered_by'.svg;
  static String get appLogo => 'app_logo'.svg;

  /// [Onboard]
  // [OnBoarding] -----> [Driver]
  static String get dOnBoard1 => 'onboarding1'.onBoarding;
  static String get dOnBoard2 => 'onboarding2'.onBoarding;
  static String get dOnBoard3 => 'onboarding3'.onBoarding;

  // [OnBoarding] -----> [Customer]
  static String get cOnBoard1 => 'onboarding4'.onBoarding;
  static String get cOnBoard2 => 'onBoarding5'.onBoarding;
  static String get cOnBoard3 => 'onBoarding6'.onBoarding;

  /// [BottomNav]
  static String get home => 'home'.icon;
  static String get order => 'order'.icon;
  static String get profile => 'profile'.icon;
  static String get userprofile => 'user_profile'.icon;

  /// [Customer] & [Driver] Icon
  static String get customer => 'customer'.png;
  static String get driver => 'driver'.png;

  /// [AppBar]
  static String get notifications => 'notifications'.icon;

  /// [More]
  static String get setting => 'setting'.icon;
  static String get info => 'info'.icon;
  static String get help => 'help'.icon;
  static String get logout => 'logout'.icon;

  /// [Others]
  static String get lock => 'lock'.icon;
  static String get eye => 'eye'.icon;
  static String get eyeoff => 'eyeoff'.icon;
  static String get edit => 'edit'.icon;
  static String get email => 'email'.icon;
  static String get web => 'web'.icon;
  static String get phone => 'phone'.icon;
  static String get location => 'city'.icon;
  static String get zipCode => 'zip_code'.icon;
  static String get language => 'language'.icon;
  static String get tickcircle => 'tick-circle'.icon;
  static String get time => 'time'.icon;
  static String get user => 'user'.icon;
  static String get weight => 'weight'.icon;
  static String get sadLogout => 'logout'.svg;
  static String get materials => 'materials'.icon;
  static String get camera => 'camera'.icon;
  static String get greenphone => 'green_phone'.icon;
  static String get greenmail => 'green_mail'.icon;
  static String get greenlocation => 'green_location'.icon;
  static String get facebook => 'facebook'.icon;
  static String get google => 'google'.icon;
  static String get twitter => 'twitter'.icon;
  static String get twofa => '2fa'.svg;
  static String get verify => 'verify'.svg;
  static String get noData => 'no_data'.svg;
  static String get pattern => 'pattern'.png;
  static String get sessionExpired => 'expired'.svg;

  /// [Location]
  static String get map => 'map'.jpeg;
  static String get marker => 'marker'.png;

  /// [Json]
  static String get courier => 'courier'.json;
  static String get proutes => 'proute'.json;
  static String get notification => 'notification'.json;
  static String get proutesDetails => 'proutedetails'.json;
  static String get mapJson => 'map'.json;
  static String get twoFaJson => '2fa'.json;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get languages => 'assets/images/languages/$this.png';
  String get jpeg => 'assets/images/$this.jpeg';
  String get onBoarding => 'assets/images/onboarding/$this.png';
  String get svg => 'assets/svg/$this.svg';
  String get icon => 'assets/svg/icons/$this.svg';
  String get json => 'assets/json/$this.json';
}
