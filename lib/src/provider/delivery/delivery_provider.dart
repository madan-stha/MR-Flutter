import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class DeliveryProvider extends ChangeNotifier {
  List<DeliveryModel> _deliveryData = [];
  List<DeliveryModel> get deliveryData => _deliveryData;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final HttpRepo _httpRepo = HttpServices();

  fetchData() async {
    try {
      var data = await _httpRepo.get(
        ApiConstant.deliveryRoutesUri,
      );

      var decodedResponses = deliveryModelFromJson(
        json.encode(
          data.data,
        ),
      );

      //*------------- Static Data ------------- //
      // String data = await rootBundle.loadString(Assets.proutes);
      // var decodedResponses = pickUpRoutesModelFromJson(
      //   data,
      // );
      //* ----------- End of Static Data --------- //

      _deliveryData = decodedResponses;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw e.toString();
    }
  }
}
