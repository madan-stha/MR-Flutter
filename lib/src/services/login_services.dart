import '../src.dart';

class LoginCredentials {
  static getLoginCreds() async {
    try {
      String fcmToken = await Utility.onGetFCMToken();
      return {
        'fcmToken': fcmToken,
      };
    } catch (e) {
      return CustomToast.show(
        'Initialization Failed, Please try again...!!',
      );
    }
  }
}
