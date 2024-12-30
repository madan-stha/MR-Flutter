import 'package:flutter/material.dart';

import '../src.dart';

class LoginProvider with ChangeNotifier {
  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    final HttpRepo _httpRepo = HttpServices();

    final SharedPreferencesService _sharedPrefs = SharedPreferencesService();

    try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': 'Logging in...',
        },
      );

      final loginCreds = await LoginCredentials.getLoginCreds();
      bool firstLogin = await _sharedPrefs.getBoolPref('firstLogin') ?? true;

      Map<String, String> body = <String, String>{
        'email': email,
        // 'token': loginCreds['fcmToken'],
        'password': password
      };
      print('body---> ${body}');

      var response = await _httpRepo.post(
        '${GlobalConfig.baseUrl}${ApiConstant.loginUri}',
        body,
        requiresToken: false,
      );

      if (firstLogin) {
        // If it's the first login, set firstLogin to false after setting it to true
        await _sharedPrefs.setBoolPref(
          'firstLogin',
          false,
        );
      }

      // response.data['email'] = email;
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
      var twoFA = response.twoFa;
      bool isDriver = response.role == "driver";

      print('isSuccess---> $isSuccess');
      print('force2FA---> $force2FA');
      print('twoFA---> $twoFA');
      print('isDriver---> $isDriver');
      print('isFirstTimeLogin---> $firstLogin');

      print('response --> ${response.accessToken}');
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
          twoFa: twoFA,
          isRoleDriver: isDriver,
          isFirstTimeLogin: firstLogin,
        );
      } else if (!isSuccess && response.status != "success") {
        Navigator.of(context).pop();
      }
    } catch (e, s) {
      print('errr---> $e ---- $s');
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      notifyListeners();
      CustomToast.show(
        e is String ? e : 'Something went wrong',
        isSuccess: false,
      );
    }
    //  finally {
    //   Navigator.of(context).pop();
    // }
  }

  void onNavigate(context, {f2fa, twoFa, isFirstTimeLogin, isRoleDriver}) {
    if (f2fa && twoFa) {
      Utility.navigate(context, '/2fa-screen');
    } else if (f2fa) {
      Utility.navigate(context, '/2fa-screen');
    } else if (twoFa) {
      Utility.navigateMaterialRoute(
        context,
        const VerificationScreen(),
      );
    } else {
      if (isFirstTimeLogin) {
        Utility.navigateMaterialRoute(
          context,
          OnBoardingScreen(
            isRoleDriver: isRoleDriver,
          ),
        );
      } else {
        Utility.navigate(
          context,
          AppRoutes.dashboardScreen,
        );
      }
    }
  }
}
