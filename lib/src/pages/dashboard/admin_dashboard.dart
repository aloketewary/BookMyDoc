import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:doctor_booking_app/src/model/router_data.dart';
import 'package:doctor_booking_app/src/pages/dashboard/appointments/dashboard_appointment_mini_card.dart';
import 'package:doctor_booking_app/src/pages/dashboard/chart/time_series.dart';
import 'package:doctor_booking_app/src/pages/dashboard/chart/time_series_chart.dart';
import 'package:doctor_booking_app/src/themes/styles.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'glance/dashboard_glance_card.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({this.routerData, this.prefs, this.onDoctorCardTap});

  final RouterData routerData;
  final SharedPreferences prefs;
  final Function onDoctorCardTap;

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  SharedPreferences get prefs => widget.prefs;

  RouterData get routerData => widget.routerData;

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
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: BmdAppBar(
        leading: null,
        title: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Hi, ${routerData.userDetails.name.split(' ')[0]}!',
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
                  monthColor: isDark
                      ? themeData.accentColor
                      : themeData.primaryColorDark,
                  dayColor:
                      isDark ? themeData.accentColor : themeData.primaryColor,
                  dayNameColor:
                      isDark ? themeData.primaryColor : Styles.nearlyWhite,
                  //Color(0xFF333A47),
                  activeDayColor:
                      isDark ? themeData.primaryColor : Styles.nearlyWhite,
                  activeBackgroundDayColor: themeData.accentColor,
                  dotsColor:
                      isDark ? themeData.primaryColor : Styles.nearlyWhite,
                  //Color(0xFF333A47),
                  // selectableDayPredicate: (date) => date.day != 23,
                  locale: 'en',
                ),
                _buildSectionName(context, titleText: 'Daily Appointments'),
                _generateChartForPrevDays(context),
                _buildSectionName(context, titleText: 'Glance'),
                _buildDashboardGlance(context),
                _buildAppointments(context),
              ]),
        ),
      ),
    );
  }

  Widget _generateChartForPrevDays(BuildContext context) {
    final data = [
      TimeSeriesSales(DateTime(2017, 9, 1), 5),
      TimeSeriesSales(DateTime(2017, 9, 2), 5),
      TimeSeriesSales(DateTime(2017, 9, 3), 25),
      TimeSeriesSales(DateTime(2017, 9, 4), 100),
      TimeSeriesSales(DateTime(2017, 9, 5), 75),
      TimeSeriesSales(DateTime(2017, 9, 6), 88),
      TimeSeriesSales(DateTime(2017, 9, 7), 65),
      TimeSeriesSales(DateTime(2017, 9, 8), 91),
      TimeSeriesSales(DateTime(2017, 9, 9), 100),
    ];
    var chartData = [
      charts.Series<TimeSeriesSales, String>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) =>
              DateFormat('dd').format(sales.time),
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (TimeSeriesSales sales, _) =>
              '${sales.sales.toString()}')
    ];
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 180,
        child: TimeSeriesBar(chartData));
  }

  Widget _buildDashboardGlance(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [DashboardGlanceCard(
              icon: MdiIcons.stethoscope,
              subTitleText: 'Doctors',
              titleText: '32',
              onCardTap: widget.onDoctorCardTap,
            ), DashboardGlanceCard(
              icon: MdiIcons.accountDetails,
              subTitleText: 'Users',
              titleText: '25',
            )],
          ),
        ],
      ),
    );
  }
}

Container _buildSectionName(BuildContext context, {String titleText = '', String subTitleText = ''}) {
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
            titleText,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            subTitleText,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    ),
    Padding(padding: EdgeInsets.only(top: 8)),
  ]));
}

Container _buildAppointments(BuildContext context) {
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
                style: Theme.of(context).textTheme.subtitle2,
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
