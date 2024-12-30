import 'package:flutter/material.dart';
import '../src.dart';

class VerifyOtpProvider with ChangeNotifier {
  Future<void> verifyOtp(
      BuildContext context, String otp, String email) async {
    final HttpRepo _httpRepo = HttpServices();
    final SharedPreferencesService _sharedPrefs = SharedPreferencesService();

    try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': 'Verifying OTP...',
        },
      );

      Map<String, String> body = <String, String>{
        'otp': otp,
        'email': email,
      };
      print('body---> ${body}');

      var response = await _httpRepo.post(
        '${GlobalConfig.baseUrl}${ApiConstant.verifyOtpUri}',
        body,
        requiresToken: false,
      );

      bool isSuccess = response.status == "success";
      print('isSuccess---> $isSuccess');

      CustomToast.show(
        Utility.isAccessible(response.message)
            ? response.message
            : AppString.somethingWentWrong,
        isSuccess: isSuccess,
      );

      if (isSuccess) {
        // Save hash or handle successful OTP verification as needed
        await _sharedPrefs.setStringPref('otpHash', response.hashCode);

        // Navigate to the next screen or home screen
        Utility.navigate(context, AppRoutes.loginScreen);
      } else {
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
}
