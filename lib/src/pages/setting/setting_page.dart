import 'package:doctor_booking_app/src/model/router_data.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  SettingPage({this.routerData, this.prefs, this.onDoctorCardTap});

  final RouterData routerData;
  final SharedPreferences prefs;
  final Function onDoctorCardTap;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with SingleTickerProviderStateMixin {
  RouterData get routerData => widget.routerData;
  TabController _tabController;
  List<Tab> tabList = <Tab>[];

  @override
  void initState() {
    tabList.add(Tab(
      text: 'Account',
    ));
    tabList.add(Tab(
      text: 'Shop',
    ));
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              'Settings',
              style: Theme.of(context).textTheme.headline5,
            )),
        leading: null,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              leading: CircleAvatar(
                radius: 35,
              ),
              title: Text(
                routerData.userDetails.name,
                style: themeData.textTheme.bodyText2,
              ),
              subtitle: Text(
                routerData.userDetails.email,
                style: themeData.textTheme.subtitle1,
              ),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {}),
            ),
            Container(
              // decoration: BoxDecoration(color: themeData.primaryColor),
              child: TabBar(
                  labelColor: isDark ? themeData.accentColor : themeData.primaryColor,
                  labelStyle: themeData.textTheme.subtitle1,
                  controller: _tabController,
                  indicatorColor: themeData.accentColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: tabList),
            ),
            Container(
              height: size.height,
              width: size.width,
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    Container(
                      child: Text('tab.text'),
                    ),
                    Container(
                      child: Text('tab.text'),
                    )
                  ]),
            )
          ],
        ),
      )),
    );
  }

  Widget _getPage(Tab tab) {
    switch (tab.text) {
      case 'Overview':
        return Container(
          child: Text(tab.text),
        );
      case 'Workouts':
        return Container(
          child: Text(tab.text),
        );
    }
    return Container(
      child: Text(tab.text),
    );
  }
}
