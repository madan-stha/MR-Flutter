import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class TwoFaProvider extends ChangeNotifier {
  late TwoFaModel _twoFA;
  TwoFaModel get twoFA => _twoFA;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final HttpRepo _httpRepo = HttpServices();

  TwoFaProvider() {
    _twoFA = TwoFaModel(
      qrCodeUrl: "",
      secretKey: "",
    );
  }

  fetchData(context, {id}) async {
    try {
      var twoFaInfo;
      print("id---> $id");

      Map<String, String> body = <String, String>{
        "user": id,
      };
      print("body---> $body");
      var response = await _httpRepo.post(
        ApiConstant.enable2FAUri,
        body,
      );
      print('response---> ${response.data}');

      var decodedResponses = twoFaModelFromJson(
        json.encode(
          response.data,
        ),
      );

      //*------------- Static Data ------------- //
      // String data = await rootBundle.loadString(Assets.twoFaJson);
      // var decodedResponses = twoFaModelFromJson(
      //   data,
      // );
      //* ----------- End of Static Data --------- //

      twoFaInfo = decodedResponses;
      if (twoFaInfo != null) {
        _twoFA = twoFaInfo;
      }
      // var success = response.status == "success";
      // if (success) {
      //   Utility.navigateMaterialRoute(
      //     context,
      //     TwoFaCard(
      //       datas: _twoFA,
      //     ),
      //   );

      _isLoading = false;
      notifyListeners();
      // }
    } catch (e, s) {
      print('err----> $e -----> $s');
      _isLoading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  Future<void> validate2FA(
    BuildContext context,
    Map<String, dynamic> twoFaObj,
  ) async {
    final HttpRepo _httpRepo = HttpServices();
    try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': AppString.msgValidating2FA,
        },
      );
      var data = DataUtility.getFormData(
        twoFaObj,
      );
      var response = await _httpRepo.post(
        ApiConstant.verify2FAUri,
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
