import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:smc_flutter/src/src.dart';

class ProutesDetailProvider extends ChangeNotifier {
  late ProuteDetailModel _pickUpRoutesDetail;
  ProuteDetailModel get pickUpRoutesDetail => _pickUpRoutesDetail;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final HttpRepo _httpRepo = HttpServices();

  fetchData({id}) async {
    try {
      var data = await _httpRepo.get(
        "${ApiConstant.pickUpRoutesUri}/$id",
      );
      if (data.status == "success" && data.data != null) {
        var decodedResponses = prouteDetailModelFromJson(
          json.encode(data.data),
        );
        _pickUpRoutesDetail = decodedResponses;
      }

      // // //*------------- Static Data ------------- //
      // String data = await rootBundle.loadString(Assets.proutesDetails);
      // var decodedResponse = prouteDetailModelFromJson(
      //   data,
      // );

      // _pickUpRoutesDetail = decodedResponse;
      // //* ----------- End of Static Data --------- //

      _isLoading = false;
      notifyListeners();
    } catch (e, s) {
      print('pickup error---> $e------ stack ----> $s');
      _isLoading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  Future<void> updateRouteStatus(
    BuildContext context,
    String status,
    id,
  ) async {
    Map<String, dynamic> body = {
      "status": status,
    };
    try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': 'Updating...',
        },
      );
      print('updateObj---> ${body}');

      var response = await _httpRepo.patch(
        "${ApiConstant.pickUpRoutesUri}/$id",
        body,
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
      print('isSuccess---> $isSuccess');
      if (isSuccess) {
        onNavigate(context);
      }
      // return response.data;
    } catch (e, s) {
      print('error ---> $e------------ $s');
      handleSubmissionError(e);
    }
  }

  Future<void> updatePickup(
    BuildContext context,
    Map<String, dynamic> updateObj,
    id, {
    List<XFile> images = const [],
  }) async {
    print('url---> ${ApiConstant.schedulePickUpRoutesUri}/$id');

    // try {
      DialogManager.showModalDialouge(
        context,
        null,
        true,
        {
          'text': 'Updating...',
        },
      );
      print('updateObj---> ${updateObj.toString()}');
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

          var test= await images[i].readAsBytes();
          formData.files.add(
            MapEntry(
              'image[$i]',
              dio.MultipartFile.fromBytes(
                test,
                filename: fileName,
              ),
            ),
          );
        }
      }
      print('updateObj---> ${formData.toString()}');

      var response = await _httpRepo.post(
        "${ApiConstant.schedulePickUpRoutesUri}/$id",
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
      print('isSuccess---> $isSuccess');
      if (isSuccess) {
        onNavigate(context);
      }
    //   return response.data;
    // } catch (e, s) {
    //   print('error ---> $e------------ $s');
    //   handleSubmissionError(e);
    // }
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
