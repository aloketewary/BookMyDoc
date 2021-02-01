import 'package:doctor_booking_app/src/app/book_my_doc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app/book_my_doc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  var prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  setupLocator();
  // NetworkConnectivityCheck connectionStatus =
  // NetworkConnectivityCheck.getInstance();
  // connectionStatus.initialize();
  runApp(Material(
    child: BookMyDoc(prefs: prefs),
  ));
}

void setupLocator() {
  // _getIt.registerSingleton(CallAndMessageService());
  // _getIt.registerSingleton(SharedServices());
}
