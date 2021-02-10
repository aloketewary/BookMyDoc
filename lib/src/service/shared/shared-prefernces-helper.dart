import 'dart:convert';

import 'package:doctor_booking_app/src/model/user-details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _loggedUserKey = 'logged_in_user_key';
  static final String _onBoardingStatus = 'on_boarding_status';
  static final String _loginPermission = 'login_permission';

  static UserDetails getLoggedUserData(SharedPreferences prefs) {
    var val = prefs.containsKey(_loggedUserKey)
        ? prefs.getString(_loggedUserKey)
        : null;
    return val != null ? UserDetails.fromMap(json.decode(val), '') : val;
  }

  static bool getOnBoardingStatus(SharedPreferences prefs) {
    return prefs.containsKey(_onBoardingStatus)
        ? prefs.getBool(_onBoardingStatus ?? false)
        : false;
  }

  static bool isLoginPermissionComplete(SharedPreferences prefs) {
    return prefs.containsKey(_loginPermission)
        ? prefs.getBool(_loginPermission ?? false)
        : false;
  }

  static Future<bool> setOnBoardingStatus(bool value, SharedPreferences prefs) {
    return prefs.setBool(_onBoardingStatus, value);
  }


  static void setLoggedUserData(UserDetails user, SharedPreferences prefs) {
    prefs.setString(_loggedUserKey, json.encode(user));
  }
}
