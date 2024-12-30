import 'package:dio/dio.dart';

class DataUtility {
  static getFormData(data) {
    FormData formData = FormData.fromMap(data);
    return formData;
  }
}
