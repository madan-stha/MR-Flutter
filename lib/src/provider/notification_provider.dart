// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smc_flutter/src/src.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notification = [];
  List<NotificationModel> get notification => _notification;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // final HttpRepo _httpRepo = HttpServices();

  fetchData() async {
    try {
      // var data = await _httpRepo.get(
      //   ApiConstant.pickUpRoutesUri,
      // );

      // var decodedResponses = pickUpRoutesModelFromJson(
      //   json.encode(
      //     data.data,
      //   ),
      // );

      //*------------- Static Data ------------- //
      String data = await rootBundle.loadString(Assets.notification);
      var decodedResponses = notificationModelFromJson(
        data,
      );
      //* ----------- End of Static Data --------- //

      _notification = decodedResponses;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e.toString();
    }
  }
}
