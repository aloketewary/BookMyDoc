import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_app/src/common/CommonWidgets.dart';
import 'package:doctor_booking_app/src/dashboard/AdminDashboard.dart';
import 'package:doctor_booking_app/src/database/notifier/users_notifier.dart';
import 'package:doctor_booking_app/src/login/getting_started.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _userId = '';
  String _email = '';

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
          _email = user?.email;
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
                loginCallback: (String uid) => loginCallback(uid),
              )
            : OnBoarding(
                auth: widget.auth,
                onBoardingCompleteCallback: onBoardingCompleteCallback,
                prefs: prefs,
              );
        break;
      case AuthStatus.loggedIn:
        return AdminDashboard();
      case AuthStatus.firstTimeLoggedIn:
        return _checkUserExistAndRouteAccordingly(context);
      case AuthStatus.notDetermined:
      default:
        return CommonWidgets.loadingIndicator(context, isDark);
    }
  }

  void loginCallback(String uid) {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
        _email = user?.email;
      });
      checkFirstTimeUser();
    });
  }

  Widget _checkUserExistAndRouteAccordingly(BuildContext context) {
    final _usersNotifier = Provider.of<UsersNotifier>(context);
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    return FutureBuilder(
        future: _usersNotifier.getSingleUserCollection(_userId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
            DocumentSnapshot _documentSnapshot =
                snapshot.data.docs.elementAt(0);
            var user = UserDetails.fromMap(
                _documentSnapshot.data(), _documentSnapshot.id);
            // SharedPreferencesHelper.setLoggedUserData(user, prefs);
            // SharedPreferencesHelper.setFirstTimeUser(false, prefs);
            // return new WillPopScope(
            //   onWillPop: onWillPop,
            //   child: new Home(
            //     userDetails: user,
            //     auth: widget.auth,
            //     userId: _userId,
            //     phoneNumber: _phoneNumber,
            //     logoutCallback: () => logoutCallback(userDetailsProvider),
            //     userUpdateCallback: userUpdateCallback,
            //     dialCode: _dialCode,
            //   ),
            return AdminDashboard();
            // )
          } else if (snapshot.hasData && snapshot.data.docs.isEmpty) {
            return WillPopScope(
                onWillPop: () => null,
                child: GettingStarted(
                  userId: _userId,
                  email: _email,
                  checkFirstTimeUserCallback: checkFirstTimeUser,
                  prefs: prefs,
                ));
          } else {
            return CommonWidgets.loadingIndicator(context, isDark);
          }
        });
  }
}
