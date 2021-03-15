import 'package:doctor_booking_app/src/themes/theme_enum.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static final TEXT_THEME_DATA = TextTheme(
      headline1: TextStyle(fontSize: 112),
      headline2: TextStyle(fontSize: 84),
      headline3: TextStyle(fontSize: 48),
      headline4: TextStyle(fontSize: 34),
      headline5: TextStyle(fontSize: 26),
      headline6: TextStyle(fontSize: 22),
      bodyText1: TextStyle(fontSize: 28),
      bodyText2: TextStyle(fontSize: 24),
      subtitle1: TextStyle(fontSize: 18),
      subtitle2: TextStyle(fontSize: 14));

  static final LIGHT_PRIMARY = Color(0XFFF91F17);
  static final LIGHT_PRIMARY_DARK = Color(0XFF84889C);
  static final LIGHT_ACCENT = Color(0XFF606365);
  static final LIGHT_BACKGROUND = Color(0XFFE0E2E3);
  static final LIGHT_BACKGROUND_DARK = Color(0XFF9FA1A6);
  static final GREY = Color(0XFFFDFBF0);
  static final GREY_DARK = Color(0XFF606366);
  static final WHITE = Color(0XFFFFFFFF);
  static final DARK = Color(0XFF09060A);
  static final BODY = Color(0XFFE2E6E8);
  static final DARK_BODY = Color(0XFF29272e);
  static final RED = Color(0XFFED1C36);
  static final RED_DARK = Color(0XFFAE1825);
  static final RED_LIGHT = Color(0XFFF91F17);
  static final APP_GREY = Color(0XFFAAA59F);
  static final APP_GREY_DARK = Color(0XFF788A99);
  static final APP_GREY_DARKER = Color(0XFF522E24);
  static final BLUE_DARK = Color(0XFF131314);
  static final BOTTOM_BAR = Color(0XFFB5C4CC);
  static final RED_DARKER = Color(0XFF470102);

  /* Custom theme */
  static const Color orange = Color(0xFFFAAB1A);
  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color darkGrey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  static final DARK_THEME = ThemeData(
      brightness: Brightness.dark,
      primaryColor: DARK_BODY,
      primaryColorDark: BLUE_DARK,
      typography: Typography.material2018(),
      backgroundColor: BODY,
      accentColor: GREY,
      appBarTheme: AppBarTheme(
        elevation: 2,
      ),
      //Color(0XFF233C63), FC2041, 04050B, 4C5463, 84889C, A7AAbB0, , FD132C, 070D30
      textTheme: TEXT_THEME_DATA,
      fontFamily: 'Gidolinya');

  static final LIGHT_THEME = ThemeData(
    brightness: Brightness.light,
    primaryColor: grey,
    primaryColorDark: darkGrey,
    typography: Typography.material2018(),
    backgroundColor: nearlyWhite,
    accentColor: orange,
    appBarTheme: AppBarTheme(
      elevation: 2,
    ),
    //Color(0XFF233C63), FC2041, 04050B, 4C5463, 84889C, A7AAbB0, , FD132C, 070D30
    textTheme: TEXT_THEME_DATA,
    fontFamily: 'Gidolinya',
  );

  static ThemeData lightThemeData(Themes themeTypes, BuildContext context) {
    if (Themes.dark == themeTypes) {
      return DARK_THEME;
    }
    return LIGHT_THEME;
  }

  static ThemeData darkThemeData(Themes themeTypes, BuildContext context) {
    if (Themes.light == themeTypes) {
      return LIGHT_THEME;
    }
    return DARK_THEME;
  }
}
