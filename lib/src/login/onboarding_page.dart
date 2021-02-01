import 'package:doctor_booking_app/src/login/intro_widget.dart';
import 'package:doctor_booking_app/src/service/base/base-auth.dart';
import 'package:doctor_booking_app/src/service/shared/shared-prefernces-helper.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({this.auth, this.onBoardingCompleteCallback, this.prefs});

  final BaseAuth auth;
  final VoidCallback onBoardingCompleteCallback;
  SharedPreferences prefs;

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller;
  int currentPageValue = 0;
  int previousPageValue = 0;
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double _moveBar = 0.0;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _init() async {
    prefs = await SharedPreferences.getInstance();
    controller = PageController(initialPage: currentPageValue);
  }


  void getChangedPageAndMoveBar(int page) {
    print('page is $page');
    currentPageValue = page;

    if (previousPageValue == 0) {
      previousPageValue = currentPageValue;
      _moveBar = _moveBar + 0.14;
    } else {
      if (previousPageValue < currentPageValue) {
        previousPageValue = currentPageValue;
        _moveBar = _moveBar + 0.14;
      } else {
        previousPageValue = currentPageValue;
        _moveBar = _moveBar - 0.14;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    final introWidgetsList = <Widget>[
      IntroWidget(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        image: 'assets/img/event_illustration4.png',
        type: 'DONATE',
        startGradientColor: Colors.orange,
        endGradientColor: Colors.lightGreen,
        subText: 'Donate to individuals in one step, by directly connected with them from your contacts.'.toUpperCase(),
        icon: MdiIcons.charity,
      ),
      IntroWidget(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          image: 'assets/img/event_illustration.png',
          type: 'SEARCH',
          startGradientColor: Colors.green,
          endGradientColor: Colors.blue,
          icon: MdiIcons.accountSearchOutline,
          subText: 'search right from the menu, search based on your location and selected bllod group.'.toUpperCase()),
      IntroWidget(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          image: 'assets/img/event_illustration3.png',
          type: 'BE A HERO',
          startGradientColor: Colors.orange,
          endGradientColor: Colors.red,
          icon: MdiIcons.charity,
          subText: 'be a superhero by saving other lives, you can save life of 4 or more people by donating blood.'.toUpperCase()),
      IntroWidget(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          image: 'assets/img/event_illustration2.png',
          type: 'READY?',
          startGradientColor: Colors.blue,
          endGradientColor: Colors.green,
          icon: MdiIcons.charity,
          subText: 'Are you ready to join the noble cause of donating blood. Get Started by tapping the button.'.toUpperCase()),
    ];
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                PageView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: introWidgetsList.length,
                  onPageChanged: (int page) {
                    getChangedPageAndMoveBar(page);
                  },
                  controller: controller,
                  itemBuilder: (context, index) {
                    return introWidgetsList[index];
                  },
                ),
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 35),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < introWidgetsList.length; i++)
                            if (i == currentPageValue) ...[circleBar(true)]
                            else
                              circleBar(false),
                        ],
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: currentPageValue == introWidgetsList.length - 1
                      ? true
                      : false,
                  child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Container(
                      margin: EdgeInsets.only(right: 16, bottom: 16),
                      child: FloatingActionButton(
                        onPressed: () {
                          SharedPreferencesHelper.setOnBoardingStatus(true, prefs);
                          widget.onBoardingCompleteCallback();
                        },
//                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(26))),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Container movingBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: screenWidth * 0.1,
      decoration: BoxDecoration(color: Colors.grey),
    );
  }

  Widget slidingBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: screenWidth * 0.1,
      decoration: BoxDecoration(color: Colors.grey),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.orange  : Colors.grey ,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  Widget expandingBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 25 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.orange : Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}