import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../src.dart';

class SharedPreferencesService {
  static SharedPreferences prefs = '' as SharedPreferences;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static bool getLangLtr() => !(prefs.getBool(AppConstants.keyLangLtr) ?? true);

  setStringPref(String key, value) async {
    try {
      await init();
      String stringValue = value is String ? value : json.encode(value);
      await prefs.setString(key, stringValue);
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getStringPref(String key) async {
    await init();
    if (prefs.containsKey(key)) {
      final value = prefs.getString(key);
      if (value != null) {
        return json.decode(value);
      }
      return null;
    } else {
      return null;
    }
  }

  setBoolPref(String key, bool value) async {
    await init();
    await prefs.setBool(key, value);
  }

  getBoolPref(String key) async {
    await init();
    if (prefs.containsKey(key)) {
      return prefs.getBool(key) ?? false;
    } else {
      return false;
    }
  }

  deleteSharedPref(dynamic key) async {
    await init();
    if (key is String) {
      if (prefs.containsKey(key)) {
        await prefs.remove(key);
      }
    } else {
      key.forEach((element) async {
        if (prefs.containsKey(element)) {
          await prefs.remove(element);
        }
      });
    }
  }
}
