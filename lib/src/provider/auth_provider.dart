import 'package:flutter/material.dart';

import '../src.dart';

class AuthProvider with ChangeNotifier {
  Future<void> changePassword(BuildContext context, String currentPassword,
      String newPassword, confirmPasswordController) async {
    final HttpRepo _httpRepo = HttpServices();

    try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': AppString.msgUpdatingPassword,
        },
      );
      Map<String, String> body = <String, String>{
        "current_password": currentPassword,
        "new_password": newPassword,
        "confirm_password": confirmPasswordController,
      };

      var response = await _httpRepo.patch(
        ApiConstant.changePassword,
        body,
      );

      var isSuccess = response.status == "success";
      Navigator.of(context).pop();
      CustomToast.show(
        Utility.isAccessible(response.exception)
            ? response.exception
            : AppString.somethingWentWrong,
        isSuccess: isSuccess,
      );
      if (isSuccess) {
        onNavigate(context);
      }
      return response.data;
    } catch (e) {
      handleSubmissionError(e);
    }
  }

  void handleSubmissionError(error) {
    CustomToast.show(
      error is String ? error : 'Something went wrong',
      isSuccess: false,
    );
  }

  void onNavigate(context) {
    Utility.navigate(context, '/dashboard-screen');
  }
}
