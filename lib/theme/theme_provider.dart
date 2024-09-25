import 'package:authenticatio_samplen/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themdata = lightMode;

  ThemeData get themeData => _themdata;
  bool get isDarkMode => _themdata == darkMode;
  set themeData(ThemeData themeData) {
    _themdata = themeData;
    notifyListeners();
  }

  void toggle() {
    if (themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
