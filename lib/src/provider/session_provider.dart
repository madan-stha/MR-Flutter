import 'package:flutter/material.dart';
import '../src.dart';

class SessionProvider extends ChangeNotifier {
  SharedPreferencesService sharedPref = SharedPreferencesService();

  Future<bool> isSessionExpired() async {
    var data = await sharedPref.getStringPref('userData');
    var expiresAt = data != null ? DateTime.parse(data['expiresAt']) : null;

    print('has expired ${DateTime.now().isAfter(expiresAt!)}');

    return DateTime.now().isAfter(expiresAt);
  }

  Future<String> remainingTime() async {
    var data = await sharedPref.getStringPref('userData');
    var expiresAt = data != null ? DateTime.parse(data['expiresAt']) : null;
    print(
        'get Remaining time from dateutility ${DateUtility.getRemainingTime(expiresAt!)}');
    return DateUtility.getRemainingTime(expiresAt);
  }
}
