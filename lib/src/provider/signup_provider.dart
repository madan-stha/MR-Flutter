import 'package:flutter/material.dart';
import '../src.dart'; // Adjust the import according to your project structure

class SignupProvider with ChangeNotifier {
  Future<void> signupUser(
      BuildContext context, String name, String email, String password, String confirmPassword) async {
    final HttpRepo _httpRepo = HttpServices();
    final SharedPreferencesService _sharedPrefs = SharedPreferencesService();

    try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': 'Registering...',
        },
      );

      Map<String, String> body = <String, String>{
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      };
      print('body---> $body');

      var response = await _httpRepo.post(
        '${GlobalConfig.baseUrl}${ApiConstant.registerUri}',
        body,
        requiresToken: false,
      );

      await _sharedPrefs.setStringPref(
        'userData',
        response,
      );

      await _sharedPrefs.setBoolPref(
        'logged',
        true,
      );

      var isSuccess = response.status == "success";
      var force2FA = response.f2fa;
      // var twoFA = response['2fa'];
      bool isCustomer = response.role == "customer";

      print('isSuccess---> $isSuccess');
      print('force2FA---> $force2FA');
      // print('twoFA---> $twoFA');
      print('isCustomer---> $isCustomer');

      // print('response --> ${response.access_token}');
      CustomToast.show(
        Utility.isAccessible(response.message)
            ? response.message
            : AppString.somethingWentWrong,
        isSuccess: isSuccess,
      );

      if (isSuccess) {
        onNavigate(
          context,
          f2fa: force2FA,
          // twoFa: twoFA,
          isRoleCustomer: isCustomer,
        );
      } else if (!isSuccess && response.status != "success") {
        Navigator.of(context).pop();
      }
    } catch (e, s) {
      print('errr---> $e ---- $s');
      Navigator.of(context).pop();
      notifyListeners();
      CustomToast.show(
        e is String ? e : 'Something went wrong',
        isSuccess: false,
      );
    }
  }

  void onNavigate(context, {f2fa, twoFa, isRoleCustomer}) {
    if (f2fa && twoFa) {
      Utility.navigate(context, '/2fa-screen');
    } else if (f2fa) {
      Utility.navigate(context, '/2fa-screen');
    } else if (twoFa) {
      Utility.navigateMaterialRoute(context, '/verification-screen');
    } else {
      Utility.navigate(
        context,
        AppRoutes.dashboardScreen,
      );
    }
  }
}
