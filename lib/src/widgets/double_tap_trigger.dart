import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

DateTime? currentBackPressTime;
//----- Double tap to go back -----
Future<bool> doubleTapTrigger() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(
      msg: 'Tap again to exit',
      toastLength: Toast.LENGTH_LONG,
    );
    return Future.value(false);
  }
  SystemNavigator.pop();
  return Future.value(true);
}
