import 'package:doctor_booking_app/src/common/CommonWidgets.dart';
import 'package:doctor_booking_app/src/database/notifier/users_notifier.dart';
import 'package:doctor_booking_app/src/login/login_screen.dart';
import 'package:doctor_booking_app/src/login/onboarding_page.dart';
import 'package:doctor_booking_app/src/model/user-details.dart';
import 'package:doctor_booking_app/src/service/auth/auth-status.dart';
import 'package:doctor_booking_app/src/service/base/base-auth.dart';
import 'package:doctor_booking_app/src/service/provider/user-details-provider.dart';
import 'package:doctor_booking_app/src/service/shared/shared-prefernces-helper.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DecisionMaker extends StatefulWidget {
  DecisionMaker({this.auth, this.user, this.prefs});

  final BaseAuth auth;
  final UserDetails user;
  final SharedPreferences prefs;

  @override
  _DecisionMakerState createState() => _DecisionMakerState();
}

class _DecisionMakerState extends State<DecisionMaker>
    with WidgetsBindingObserver {
  AuthStatus authStatus = AuthStatus.notDetermined;
  String _phoneNumber = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _userId = '';
  String _dialCode = '';

  UserDetails get _userDetails => widget.user;

  SharedPreferences get prefs => widget.prefs;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _init();
  }

  void _init() async {
    await widget.auth.getCurrentUser().then((user) {
      if (user != null) {
        setState(() {
          _userId = user.uid.toString();
          _phoneNumber = user?.phoneNumber;
        });
      }
      authStatus =
          user?.uid == null ? AuthStatus.notLoggedIn : AuthStatus.loggedIn;
      if (AuthStatus.loggedIn == authStatus) {
        checkFirstTimeUser();
      } else {
        setState(() {
          authStatus = AuthStatus.notLoggedIn;
        });
      }
    });
  }

  void checkFirstTimeUser() {
    setState(() {
      authStatus = _userDetails != null
          ? AuthStatus.loggedIn
          : AuthStatus.firstTimeLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: getCurrentWidgetToShow(context, userDetailsProvider),
    );
  }

  void onBoardingCompleteCallback() {
    setState(() {
      authStatus = AuthStatus.notLoggedIn;
    });
  }

  void onPermissionCompleteCallback() {
    setState(() {
      authStatus = AuthStatus.notLoggedIn;
    });
  }

  void userUpdateCallback() {
    setState(() {
      authStatus = AuthStatus.loggedIn;
    });
  }

  Widget getCurrentWidgetToShow(
      BuildContext context, UserDetailsProvider userDetailsProvider) {
    final _usersNotifier = Provider.of<UsersNotifier>(context);
    var accentColor = Theme.of(context).accentColor;
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    switch (authStatus) {
      case AuthStatus.notLoggedIn:
        return SharedPreferencesHelper.getOnBoardingStatus(prefs)
            ? LoginScreenPage(
                auth: widget.auth,
                loginCallback: (String dialCode) => loginCallback(dialCode),
              )
            : OnBoarding(
                auth: widget.auth,
                onBoardingCompleteCallback: onBoardingCompleteCallback,
                prefs: prefs,
              );
        break;
      case AuthStatus.notDetermined:
      default:
        return CommonWidgets.loadingIndicator(context, isDark);
    }
  }

  void loginCallback(String dialCode) {
    print(dialCode);
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
        _phoneNumber = user?.phoneNumber;
        _dialCode = dialCode;
      });
      checkFirstTimeUser();
    });
  }
}
