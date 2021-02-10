import 'package:doctor_booking_app/src/model/router_data.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentList extends StatefulWidget {
  AppointmentList({this.routerData, this.prefs, this.onDoctorCardTap});

  final RouterData routerData;
  final SharedPreferences prefs;
  final Function onDoctorCardTap;

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    var themeData = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BmdAppBar(
        title: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Appointments',
              style: Theme.of(context).textTheme.headline5,
            )),
        leading: null,
      ),
    );
  }
}
