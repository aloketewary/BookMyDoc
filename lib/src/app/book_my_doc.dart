import 'package:doctor_booking_app/src/dashboard/AdminDashboard.dart';
import 'package:doctor_booking_app/src/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMyDoc extends StatefulWidget {
  BookMyDoc({this.prefs});

  final SharedPreferences prefs;

  @override
  _BookMyDocState createState() => _BookMyDocState();
}

class _BookMyDocState extends State<BookMyDoc> {
  SharedPreferences get prefs => widget.prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book My Doc',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          // primaryColor:  Color(0xFF2758E4),
          backgroundColor: BmdColors.lightGrey,
          accentColor: Color(0xFF2758E4)),
      darkTheme: ThemeData(
          // primaryColor:  Color(0xFF2758E4),
          backgroundColor: BmdColors.lightGrey,
          accentColor: Color(0xFF2758E4)),
      home: AdminDashboard(
        prefs: prefs,
      ),
    );
  }
}
