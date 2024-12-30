import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class  UserProvider extends ChangeNotifier {
   UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final HttpRepo _httpRepo = HttpServices();

  fetchData() async {
    try {
      var userInfo;
      var response = await _httpRepo.get(
        ApiConstant.profileUri,
      );
      print('data---> ${response.data}');
      var decodedResponses = userModelFromJson(
        json.encode(
          response.data["user"],
        ),
      );
      userInfo = decodedResponses;
      if (userInfo != null) {
        _user = userInfo;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e, s) {
      print('err----> $e -----> $s');

      _isLoading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  Future<void> updateProfile(
    BuildContext context,
    Map<String, dynamic> profileObj,
  ) async {
    final HttpRepo _httpRepo = HttpServices();
    try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': AppString.msgUpdatingProfile,
        },
      );
      var data = DataUtility.getFormData(
        profileObj,
      );
      var response = await _httpRepo.post(
        ApiConstant.updateProfileUri,
        data,
      );
      print('response---> ${response.data}');

      var isSuccess = response.status == "success";
      Navigator.of(context).pop();
      CustomToast.show(
        Utility.isAccessible(response.message)
            ? response.message
            : AppString.somethingWentWrong,
        isSuccess: isSuccess,
      );
      if (isSuccess) {
        onNavigate(context);
      }
      return response.data;
    } catch (e, s) {
      print('error ---> $e------------ $s');
      handleSubmissionError(e);
    }
  }

  void onNavigate(context) {
    Utility.navigate(context, '/dashboard-screen');
  }

  void handleSubmissionError(error) {
    CustomToast.show(
      error is String ? error : 'Something went wrong',
      isSuccess: false,
    );
  }
}
