import 'package:smc_flutter/src/src.dart';

class Validator {
  static String? validatePassword(String value) {
    if (value.isEmpty || value.length < 8) {
      return AppString.msgPasswordMustBeMoreThan8;
    }
    return null;
  }

  static String? validateConfirmPassword(String value, String password) {
    return value == password ? null : AppString.msgPasswordDoesNotMatch;
  }

  static String? validateEmpty(String value) {
    return value.isNotEmpty ? null : AppString.msgValidateEmptyField;
  }
}
