import 'package:doctor_booking_app/src/model/router_data.dart';
import 'package:doctor_booking_app/src/pages/appointments/appointment_list.dart';
import 'package:doctor_booking_app/src/pages/dashboard/admin_dashboard.dart';
import 'package:doctor_booking_app/src/pages/doctors/doctors_list.dart';
import 'package:doctor_booking_app/src/pages/setting/setting_page.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BmdHome extends StatefulWidget {
  BmdHome({this.routerData, this.prefs});

  final RouterData routerData;
  final SharedPreferences prefs;

  @override
  _BmdHomeState createState() => _BmdHomeState();
}

class _BmdHomeState extends State<BmdHome> {
  int _currentIndex = 0;
  PageController _pageController;

  RouterData get _routerData => widget.routerData;

  SharedPreferences get _prefs => widget.prefs;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              AdminDashboard(
                  prefs: _prefs,
                  routerData: _routerData,
                  onDoctorCardTap: onDoctorCardTap),
              AppointmentList(
                prefs: _prefs,
                routerData: _routerData,
              ),
              DoctorsList(
                prefs: _prefs,
                routerData: _routerData,
              ),
              SettingPage(
                prefs: _prefs,
                routerData: _routerData,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 3,
          currentIndex: _currentIndex,
          selectedItemColor: themeData.accentColor,
          iconSize: 30,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: themeData.textTheme.subtitle1,
          unselectedItemColor: isDark
              ? themeData.accentColor.withOpacity(0.5)
              : themeData.primaryColor,
          onTap: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
              // activeColor: themeData.accentColor,
              // inactiveColor: themeData.primaryColor,
            ),
            BottomNavigationBarItem(
              label: 'Appointment',
              icon: Icon(Icons.format_list_numbered),
              // activeColor: themeData.accentColor,
              // inactiveColor: themeData.primaryColor,
            ),
            BottomNavigationBarItem(
              label: 'Doctors',
              icon: Icon(Icons.people),
              // activeColor: themeData.accentColor,
              // inactiveColor: themeData.primaryColor,
            ),
            BottomNavigationBarItem(
              label: 'Setting',
              icon: Icon(Icons.settings),
              // activeColor: themeData.accentColor,
              // inactiveColor: themeData.primaryColor,
            ),
          ],
        )

        // SizedBox(
        //   height: 60,
        //   child: BottomNavyBar(
        //     showElevation: true,
        //     selectedIndex: _currentIndex,
        //     onItemSelected: (index) {
        //       setState(() => _currentIndex = index);
        //       _pageController.jumpToPage(index);
        //     },
        //     items: <BottomNavyBarItem>[
        //       BottomNavyBarItem(
        //         title: Text('Home'),
        //         icon: Icon(Icons.home),
        //         activeColor: themeData.accentColor,
        //         inactiveColor: themeData.primaryColor,
        //       ),
        //       BottomNavyBarItem(
        //         title: Text('Users'),
        //         icon: Icon(Icons.account_circle),
        //         activeColor: themeData.accentColor,
        //         inactiveColor: themeData.primaryColor,
        //       ),
        //       BottomNavyBarItem(
        //         title: Text('Doctors'),
        //         icon: Icon(Icons.chat_bubble),
        //         activeColor: themeData.accentColor,
        //         inactiveColor: themeData.primaryColor,
        //       ),
        //       BottomNavyBarItem(
        //         title: Text('Setting'),
        //         icon: Icon(Icons.settings),
        //         activeColor: themeData.accentColor,
        //         inactiveColor: themeData.primaryColor,
        //       ),
        //     ],
        //   ),
        // ),
        );
  }

  void onDoctorCardTap() {
    setState(() => _currentIndex = 2);
    _pageController.jumpToPage(2);
  }
}
