import 'package:doctor_booking_app/src/common/common_widgets.dart';
import 'package:doctor_booking_app/src/model/router_data.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/Colors.dart';
import 'package:doctor_booking_app/src/utils/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorsList extends StatefulWidget {
  DoctorsList({this.routerData, this.prefs, this.onDoctorCardTap});

  final RouterData routerData;
  final SharedPreferences prefs;
  final Function onDoctorCardTap;

  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
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
              'Doctors',
              style: Theme.of(context).textTheme.headline5,
            )),
        leading: null,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.all(10.0),
        children: List.generate(
          options.length,
          (index) => GridOptions(
            layout: options[index],
          ),
        ),
      ),
    );
  }
}

class GridLayout {
  final String title;
  final IconData icon;

  GridLayout({this.title, this.icon});
}

List<GridLayout> options = [
  GridLayout(title: 'Home', icon: Icons.home),
  GridLayout(title: 'Email', icon: Icons.email),
  GridLayout(title: 'Alarm', icon: Icons.access_alarm),
  GridLayout(title: 'Wallet', icon: Icons.account_balance_wallet),
  GridLayout(title: 'Backup', icon: Icons.backup),
  GridLayout(title: 'Book', icon: Icons.book),
  GridLayout(title: 'Camera', icon: Icons.camera_alt_rounded),
  GridLayout(title: 'Person', icon: Icons.person),
  GridLayout(title: 'Print', icon: Icons.print),
  GridLayout(title: 'Phone', icon: Icons.phone),
  GridLayout(title: 'Notes', icon: Icons.speaker_notes),
  GridLayout(title: 'Music', icon: Icons.music_note_rounded),
  GridLayout(title: 'Car', icon: Icons.directions_car),
  GridLayout(title: 'Bicycle', icon: Icons.directions_bike),
  GridLayout(title: 'Boat', icon: Icons.directions_boat),
  GridLayout(title: 'Bus', icon: Icons.directions_bus),
  GridLayout(title: 'Train', icon: Icons.directions_railway),
  GridLayout(title: 'Walk', icon: Icons.directions_walk),
  GridLayout(title: 'Contact', icon: Icons.contact_mail),
  GridLayout(title: 'Duo', icon: Icons.duo),
  GridLayout(title: 'Hour', icon: Icons.hourglass_bottom),
  GridLayout(title: 'Mobile', icon: Icons.mobile_friendly),
  GridLayout(title: 'Message', icon: Icons.message),
  GridLayout(title: 'Key', icon: Icons.vpn_key),
  GridLayout(title: 'Wifi', icon: Icons.wifi),
  GridLayout(title: 'Bluetooth', icon: Icons.bluetooth),
  GridLayout(title: 'Smile', icon: Icons.sentiment_satisfied),
  GridLayout(title: 'QR', icon: Icons.qr_code),
  GridLayout(title: 'ADD', icon: Icons.add_box),
  GridLayout(title: 'Link', icon: Icons.link),
];

class GridOptions extends StatelessWidget {
  final GridLayout layout;

  GridOptions({this.layout});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accentColor = Theme.of(context).accentColor;
    final primaryColor = Theme.of(context).primaryColor;
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    final _size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Container(
            height: 180,
            width: 140,
            margin: EdgeInsets.only(right: 10),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.lightDarkCard
                                : Colors.grey.shade200),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: -10,
                                right: -110,
                                child: CommonWidgets.circularContainer(
                                    240,
                                    isDark
                                        ? AppColors.darkerCard.withOpacity(0.18)
                                        : Colors.grey.shade300)),
                            Positioned(
                                top: -155,
                                right: -110,
                                child: CommonWidgets.circularContainer(
                                    _size.width * .6,
                                    isDark
                                        ? AppColors.darkerCard.withOpacity(0.35)
                                        : Colors.grey.shade500)),
                            Positioned(
                              bottom: -10,
                              right: -55,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: isDark
                                    ? AppColors.black.withOpacity(0.32)
                                    : AppColors.black.withOpacity(0.12),
                              ),
                            ),
                            // Positioned(
                            //     top: -180,
                            //     right: -30,
                            //     child: CommonWidgets.circularContainer(
                            //         _size.width * .7, Colors.transparent,
                            //         borderColor: isDark
                            //             ? Colors.black54
                            //             : Colors.white38)),
                            // Positioned(
                            //     top: -110,
                            //     right: -30,
                            //     child: CommonWidgets.circularContainer(
                            //         _size.width * .4, Colors.transparent,
                            //         borderColor: isDark
                            //             ? Colors.black54
                            //             : Colors.white60)),
                            InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                // onTapCallback();
                              },
                              splashColor: accentColor.withOpacity(0.3),
                              enableFeedback: true,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: CircleAvatar(
                                            child: Text('C',
                                                style: textTheme.headline4
                                                    .copyWith(
                                                    color: isDark
                                                        ? primaryColor
                                                        : Colors.white)),
                                            backgroundColor: isDark ? accentColor : primaryColor,
                                            radius: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Arindam Test',
                                      style: textTheme.subtitle1.copyWith(
                                          color: isDark ? accentColor.withOpacity(0.9) : primaryColor,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Test Address',
                                      style: textTheme.subtitle2.copyWith(
                                          color: isDark ? accentColor.withOpacity(0.9) : primaryColor,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                                  (states) => isDark
                                                  ? primaryColor
                                                  : accentColor.withOpacity(0.9))),
                                      child: Text(
                                        'DELETE',
                                        style:
                                        Theme.of(context).textTheme.button,
                                      ),
                                    )
                                    // CircularPercentIndicator(
                                    //   radius: 80.0,
                                    //   lineWidth: 8.0,
                                    //   percent: bloodRequest.completedUnits /
                                    //       (bloodRequest.requireUnits <
                                    //               bloodRequest.completedUnits
                                    //           ? bloodRequest.completedUnits
                                    //           : bloodRequest.requireUnits),
                                    //   circularStrokeCap:
                                    //       CircularStrokeCap.round,
                                    //   center: Image.asset(
                                    //     bloodRequest.completedUnits ==
                                    //             bloodRequest.requireUnits
                                    //         ? 'assets/img/healthcare-and-medical.png'
                                    //         : _sharedServices
                                    //             .mapDonationTypeDataWithImage(
                                    //                 bloodRequest.donationType),
                                    //     width: 45,
                                    //   ),
                                    //   progressColor: Colors.red,
                                    //   backgroundColor: isDark
                                    //       ? accentColor.withAlpha(90)
                                    //       : accentColor.withAlpha(90),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))))));
  }
}
