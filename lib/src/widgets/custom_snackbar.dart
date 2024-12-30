import 'package:flutter/material.dart';
import 'package:smc_flutter/src/src.dart';

void showCustomSnackBarHelper(context, String message, {bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: isError ? AppColors.rejectedColor : AppColors.successColor,
    content: Text(message),
  ));
}
