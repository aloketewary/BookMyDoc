import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:doctor_booking_app/src/dashboard/appointments/dashboard_appointment_mini_card.dart';
import 'package:doctor_booking_app/src/dashboard/doctors/dashboard_doctor_mini_card.dart';
import 'package:doctor_booking_app/src/doctors/doctors_details.dart';
import 'package:doctor_booking_app/src/utils/Colors.dart';
import 'package:doctor_booking_app/src/utils/CustomAppbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({this.prefs});

  final SharedPreferences prefs;

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  SharedPreferences get prefs => widget.prefs;

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('en');
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var accentColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: BmdAppBar(
        leading: null,
        title: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Hi, Arindam!',
              style: Theme.of(context).textTheme.headline6,
            )),
        onPressed: null,
        action: Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 12, right: 8),
                child: Icon(
                  Icons.search,
                  // color: Colors.tealAccent[100],
                )),
            Padding(
                padding: const EdgeInsets.only(top: 12, right: 8),
                child: Icon(
                  Icons.more_vert,
                  // color: Colors.tealAccent[100],
                )),
          ],
        ),
      ),
      // backgroundColor: Color(0xFF333A47),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CalendarTimeline(
                showYears: false,
                initialDate: _selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 2)),
                lastDate: DateTime.now().add(Duration(days: 7)),
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                leftMargin: 20,
                monthColor: Colors.black45,
                dayColor: Colors.black54,
                dayNameColor: Color(0xFFDDE3E7),
                //Color(0xFF333A47),
                activeDayColor: Colors.white,
                activeBackgroundDayColor: BmdColors.accent,
                dotsColor: BmdColors.lightGrey,
                //Color(0xFF333A47),
                // selectableDayPredicate: (date) => date.day != 23,
                locale: 'en',
              ),
              _buildAppointments(context),
              _buildAvailableDoctor(context),
              ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: 3,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return DashboardDoctorMiniCard(
                        // onTapCallback: _gotoDoctorDetails(context)
                        );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

_buildAvailableDoctor(BuildContext context) {
  return Container(
      child: Column(children: [
    Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Available Doctor',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    ),
    Padding(padding: EdgeInsets.only(top: 8)),
  ]));
}

_buildAppointments(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Appointments',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 8)),
        Container(
            height: 180,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: 3,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return DashboardAppointmentMiniCard();
                }))
      ],
    ),
  );
}
