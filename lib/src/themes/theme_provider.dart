import 'package:doctor_booking_app/src/themes/theme_enum.dart';
import 'package:doctor_booking_app/src/themes/theme_preference.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreference darkThemePreference = ThemePreference();
  Themes _themeTypes = Themes.system;

  Themes get themeTypes => _themeTypes;

  set themeTypes(Themes value) {
    _themeTypes = value;
    darkThemePreference.setTheme(value);
    notifyListeners();
  }

  bool isDark(BuildContext context) {
    final brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDarkTheme;
    switch (themeTypes) {
      case Themes.light:
        isDarkTheme = false;
        break;
      case Themes.dark:
        isDarkTheme = true;
        break;
      default:
        isDarkTheme = brightnessValue == Brightness.dark;
    }
    return isDarkTheme;
  }
}
