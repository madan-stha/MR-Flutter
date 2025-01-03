//* ------------- Global Screen --------------- //
library screen;

/// [OnBoarding] Screen
export 'onboarding/onboarding_screen.dart';

/// [Splash] Screen
export 'splash/splash_screen.dart';

/// [Auth] --> [Password]
export 'auth/forgotpassword/fpassword_screen.dart';

/// [Auth] Screen
export 'auth/login_screen.dart';

/// [Auth] --> [TwoFA]
export 'auth/2fa/two_fa_screen.dart';
export 'auth/2fa/two_card.dart';
export 'auth/2fa/generate_2fa_screen.dart';
export 'auth/2fa/verify_2fa_screen.dart';

/// [Auth] --> [Logout]
export 'auth/logout_screen.dart';

/// [Dashboard] Screen
export 'dashboard/dashboard_screen.dart';
export 'dashboard/ddashboard_screen.dart';
export 'dashboard/cdashboard_screen.dart';
export 'home/home_card.dart';

/// [Dashboard] --> [Screens]
/// [Home] Screen
export 'home/home_screen.dart';
export 'home/assigned_card.dart';

/// [Notification] Screen
export 'notification/notification_screen.dart';
export 'notification/notification_card.dart';

/// [More] Screen
export 'more/more_screen.dart';

/// [Order] Screen
export 'order/order_screen.dart';

/// [Maps] Screen
export 'map/map_screen.dart';

/// [Order] --> [PickUp] ==> [Screen, Card, Detail]
export 'order/pickup/pickup_screen.dart';
export 'order/pickup/pickup_card.dart';
export 'order/pickup/pickup_detail_screen.dart';
export 'order/pickup/pickup_material_table.dart';
export 'order/pickup/pickup_map_screen.dart';
export 'order/pickup/pickup_bottomsheet_screen.dart';
export 'order/pickup/pupdate_screen.dart';

/// [Order] --> [PickUp] --> [Widget]
export 'order/pickup/widget/pickup_detail_widget.dart';
export 'order/pickup/widget/emergency_widget.dart';
export 'order/pickup/widget/customer_detail_widget.dart';

/// [Order] --> [Delivery] ==> [Screen, Card, Detail]
export 'order/delivery/delivery_screen.dart';
export 'order/delivery/delivery_card.dart';
export 'order/delivery/delivery_detail_screen.dart';
export 'order/delivery/dupdate_screen.dart';
export 'order/delivery/add_update_materials_screen.dart';

/// [Order] --> [Delivery] --> [Widget]
export 'order/delivery/widget/trip_detail_widget.dart';
export 'order/delivery/widget/emergency_detail_widget.dart';
export 'order/delivery/widget/customer_detail_widget.dart';

/// [More] --> [Profile]
export 'profile/profile_screen.dart';

/// [More] --> [About]
export 'more/about/about_screen.dart';

/// [More] --> [Help]
export 'more/help/help_screen.dart';

/// [More] --> [Setting]
export 'more/setting/setting_screen.dart';
export 'more/setting/help/faqs_screen.dart';
export 'more/setting/notification_setting.dart';
export 'more/setting/theme_screen.dart';
export 'more/setting/profile/change_password_screen.dart';
export 'more/setting/profile/update_profile_screen.dart';
export 'confirmation/confirmation_screen.dart';

/// [More] --> [Setting] --> [Contact]
export 'more/setting/help/help_screen.dart';

/// [More] --> [Settings] --> [Language]
export 'language/language_screen.dart';

/// [Image]
export 'confirmation/upload_image_screen.dart';
