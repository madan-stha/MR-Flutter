import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

class PickUpProvider extends ChangeNotifier {
  List<PickUpRoutesModel> _pickUpRoutes = [];
  List<PickUpRoutesModel> get pickUpRoutes => _pickUpRoutes;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final HttpRepo _httpRepo = HttpServices();

  fetchData() async {
    try {
      var data = await _httpRepo.get(
        ApiConstant.pickUpRoutesUri,
      );

      var decodedResponses = pickUpRoutesModelFromJson(
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

      _pickUpRoutes = decodedResponses;
      print('pickUpRoutes ${_pickUpRoutes.length}');
      print('response body ${data.data}');
      _isLoading = false;
      notifyListeners();
    } catch (e, s) {
      print('e $e');
      print('s $s');

      _isLoading = false;
      notifyListeners();
      throw e.toString();
    }
  }
}
