import 'package:doctor_booking_app/src/service/shared/shared-prefernces-helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsProvider with ChangeNotifier {
  dynamic getLoggerUserData(SharedPreferences prefs) {
    return SharedPreferencesHelper.getLoggedUserData(prefs);
  }
}
