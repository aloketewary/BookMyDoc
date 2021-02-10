import 'package:doctor_booking_app/src/themes/theme_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const themeStatus = 'THEME_STATUS';
  static const Map<Themes, String> themes = {
    Themes.dark: 'Dark',
    Themes.light: 'Light',
    Themes.system: 'System'
  };
  static const Map<String, Themes> themesAlt = {
    'Dark': Themes.dark,
    'Light': Themes.light,
    'System': Themes.system
  };

  void setTheme(Themes value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeStatus, themes[value]);
  }

  Themes getTheme(SharedPreferences prefs) {
    var themeData = prefs.getString(themeStatus);
    return themeData != null ? themesAlt[themeData] : Themes.system;
  }
}
