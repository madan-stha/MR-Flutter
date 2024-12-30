import 'package:flutter/material.dart';

import '../model/model.dart';

class LanguageProvider extends ChangeNotifier {
  static var supportedLanguages = [
    Language(0, 'English', 'en', '🇺🇸'),
    Language(1, 'Spanish', 'es', '🇪🇸'),
  ];

  Language _currentLanguage = supportedLanguages[0]; // Default to English

  Language get currentLanguage => _currentLanguage;

  void changeLanguage(Language language) {
    try {
      _currentLanguage = language;
      notifyListeners();
    } catch (e) {
    }
  }
}
