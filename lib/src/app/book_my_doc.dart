import 'package:doctor_booking_app/src/config/decision-maker.dart';
import 'package:doctor_booking_app/src/dashboard/admin_dashboard.dart';
import 'package:doctor_booking_app/src/database/notifier/users_notifier.dart';
import 'package:doctor_booking_app/src/database/users_data_api.dart';
import 'package:doctor_booking_app/src/model/user-details.dart';
import 'package:doctor_booking_app/src/service/auth/book-my-doc-auth.dart';
import 'package:doctor_booking_app/src/service/provider/user-details-provider.dart';
import 'package:doctor_booking_app/src/themes/styles.dart';
import 'package:doctor_booking_app/src/themes/theme.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMyDoc extends StatefulWidget {
  BookMyDoc({this.prefs});

  final SharedPreferences prefs;

  @override
  _BookMyDocState createState() => _BookMyDocState();
}

class _BookMyDocState extends State<BookMyDoc> {
  SharedPreferences get prefs => widget.prefs;
  UserDetails userData;
  final UserDetailsProvider _userDetailsProvider = UserDetailsProvider();
  ThemeProvider themeChangeProvider = ThemeProvider();
  final UsersDataApi _usersDataApi = UsersDataApi();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    userData = _userDetailsProvider.getLoggerUserData(prefs);
    themeChangeProvider.themeTypes =
        themeChangeProvider.darkThemePreference.getTheme(prefs);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //     ChangeNotifierProvider(create: (_) => EventsNotifier(_eventsApi)),
          ChangeNotifierProvider(create: (_) => UsersNotifier(_usersDataApi)),
          // ChangeNotifierProvider(
          // create: (_) => BloodRequestNotifier(_bloodRequestApi)),
          // ChangeNotifierProvider(
          // create: (_) => DonorsHistoryNotifier(_donorsHistoryApi)),
          ChangeNotifierProvider(create: (_) => themeChangeProvider),
          // ChangeNotifierProvider(create: (_) => widget.appLanguage),
          ChangeNotifierProvider(create: (_) => _userDetailsProvider)
        ],
        child: Consumer<ThemeProvider>(
          builder: (BuildContext _context, value, Widget child) {
            return MaterialApp(
              title: 'Book My Doc',
              debugShowCheckedModeBanner: false,
              theme: Styles.lightThemeData(
                  themeChangeProvider.themeTypes, context),
              darkTheme:
              Styles.darkThemeData(themeChangeProvider.themeTypes, context),
              home: DecisionMaker(
                auth: BookMyDocAuth(),
                user: userData,
                prefs: prefs,
              ),
            );
          },
        ));
  }
}
