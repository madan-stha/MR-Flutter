import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class HomeProvider extends ChangeNotifier {
  List<DashboardModel> _dashboard = [];
  List<DashboardModel> get dashboard => _dashboard;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final HttpRepo _httpRepo = HttpServices();

  fetchData() async {
    try {
      var data = await _httpRepo.get(
        ApiConstant.dashboardUri,
      );

      var decodedResponses = dashboardModelFromJson(
        json.encode(
          data.data,
        ),
      );

      _dashboard = decodedResponses;

      _isLoading = false;
      notifyListeners();
    } catch (e, s) {
      print('stack --> $s----- $e');
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
