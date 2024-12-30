import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smc_flutter/src/src.dart';

class DeliveryDetailProvider extends ChangeNotifier {
  DeliveryDetailModel? _deliveryDetail;
  DeliveryDetailModel? get deliveryDetail => _deliveryDetail;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final HttpRepo _httpRepo = HttpServices();

  fetchData({id}) async {
    try {
      var deliveryInfo;
      var data = await _httpRepo.get(
        '${ApiConstant.deliveryRoutesUri}/$id',
      );

      var decodedResponses = deliveryDetailModelFromJson(
        json.encode(
          data.data,
        ),
      );

      deliveryInfo = decodedResponses;
      if (deliveryInfo != null) {
        _deliveryDetail = deliveryInfo;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e, s) {
      print('error $e------ stack$s');

      _isLoading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  startTrip({
    context,
    int? id,
    var startObj,
  }) async {
    try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': 'Starting...',
        },
      );

      print(
          ' boydy---> $startObj----> url ${ApiConstant.deliveryRoutesUri}/$id');

      var response = await _httpRepo.post(
        '${ApiConstant.deliveryRoutesUri}/$id?_method=PATCH',
        startObj,
      );
      var isSuccess = response.status == "success";
      Navigator.of(context).pop();
      CustomToast.show(
        Utility.isAccessible(response.message)
            ? response.message
            : AppString.somethingWentWrong,
        isSuccess: isSuccess,
      );
      print('respose---> ${response.message}');
      if (isSuccess) {
        onNavigate(context);
      }

      notifyListeners();
    } catch (e, s) {
      print('error $e------ stack$s');
      Navigator.of(context).pop();
      CustomToast.show(
        AppString.somethingWentWrong,
        isSuccess: false,
      );
      notifyListeners();
    }
  }

  updateData({
    context,
    id,
    updateObj,
    List<XFile> images = const [],
  }) async {
    try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': 'Updating...',
        },
      );
      // Create FormData with Dio
      dio.FormData formData = dio.FormData.fromMap(updateObj);

      // Add images as multipart fields
      for (int i = 0; i < images.length; i++) {
        if (images[i] != null) {
          String fileName = images[i].path.split('/').last;
          // final httpMultipartFile = await http.MultipartFile.fromPath(
          //   'attachment[$i]',
          //   images[i].path,
          // );
          formData.files.add(
            MapEntry(
              'attachment[$i]',
              dio.MultipartFile.fromBytes(
                await images[i].readAsBytes(),
                filename: fileName,
              ),
            ),
          );
        }
      }

      print(' attachamnt -----> $updateObj');

      print(' attachamnt -----> $updateObj');

      var response = await _httpRepo.post(
        '${ApiConstant.deliveryRoutesUri}/$id?_method=PATCH',
        formData,
      );
      var isSuccess = response.status == "success";
      Navigator.of(context).pop();
      CustomToast.show(
        Utility.isAccessible(response.message)
            ? response.message
            : AppString.somethingWentWrong,
        isSuccess: isSuccess,
      );
      print('respose---> ${response.message}');
      if (isSuccess) {
        onNavigate(context);
      }

      notifyListeners();
    } catch (e, s) {
      print('error $e------ stack$s');
      Navigator.of(context).pop();
      CustomToast.show(
        "$e",
        isSuccess: false,
      );
      notifyListeners();
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
