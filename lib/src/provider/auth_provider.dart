// import 'package:flutter/material.dart';

// import '../src.dart';

// class AuthProvider with ChangeNotifier {
//   Future<void> changePassword(BuildContext context, String currentPassword,
//       String newPassword, confirmPasswordController) async {
//     final HttpRepo _httpRepo = HttpServices();

//     try {
//       DialogManager.showModalDialouge(
//         context,
//         null,
//         true,
//         {
//           'text': AppString.msgUpdatingPassword,
//         },
//       );
//       Map<String, String> body = <String, String>{
//         "current_password": currentPassword,
//         "new_password": newPassword,
//         "confirm_password": confirmPasswordController,
//       };

//       var response = await _httpRepo.patch(
//         ApiConstant.changePassword,
//         body,
//       );
//       print('changepasswordstatus ${response.status}');
//       var isSuccess = response.status == "success";
//       Navigator.of(context).pop();
//       CustomToast.show(
//         Utility.isAccessible(response.exception)
//             ? response.exception
//             : AppString.somethingWentWrong,
//         isSuccess: isSuccess,
//       );
//       if (isSuccess) {
//         onNavigate(context);
//       }
//       return response.data;
//     } catch (e) {
//       handleSubmissionError(e);
//     }
//   }

//   void handleSubmissionError(error) {
//     CustomToast.show(
//       error is String ? error : 'Something went wrong',
//       isSuccess: false,
//     );
//   }

//   void onNavigate(context) {
//     Utility.navigate(context, '/dashboard-screen');
//   }
// }

import 'package:flutter/material.dart';
import '../src.dart';

class AuthProvider with ChangeNotifier {
  Future<void> changePassword(BuildContext context, String currentPassword,
      String newPassword, confirmPasswordController) async {
    final HttpRepo _httpRepo = HttpServices();

    try {
      // Show loading dialog
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': AppString.msgUpdatingPassword,
        },
      );

      // Prepare request body
      Map<String, String> body = <String, String>{
        "current_password": currentPassword,
        "new_password": newPassword,
        "confirm_password": confirmPasswordController,
      };

      // Send request
      var response = await _httpRepo.patch(
        ApiConstant.changePassword,
        body,
      );

      print('changepasswordstatus ${response.status}');
      var isSuccess = response.status == "success";

      // Close loading dialog
      Navigator.of(context).pop();

      // Display toast message
      if (isSuccess) {
        CustomToast.show(
          AppString.passwordChangeSuccess, // Add a success message in AppString
          isSuccess: true,
        );
        onNavigate(context); // Navigate on success
      } else {
        CustomToast.show(
          Utility.isAccessible(response.exception)
              ? response.exception
              : AppString.somethingWentWrong,
          isSuccess: false,
        );
      }

      return response.data;
    } catch (e) {
      // Handle error
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
