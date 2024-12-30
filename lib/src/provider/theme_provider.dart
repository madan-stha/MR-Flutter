import 'package:flutter/material.dart';

import '../src.dart';

class ThemeProvider with ChangeNotifier {
  final SharedPreferencesService? sharedPreferences;
  ThemeProvider({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = GlobalConfig.defaultTheme;
  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences?.setBoolPref(AppConstants.theme, _darkTheme);
    notifyListeners();
  }

  void _loadCurrentTheme() async {
    _darkTheme = sharedPreferences?.getBoolPref(AppConstants.theme) ??
        GlobalConfig.defaultTheme;
    notifyListeners();
  }
}
