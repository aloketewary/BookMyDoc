import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_app/src/database/notifier/doctors_notifier.dart';
import 'package:doctor_booking_app/src/model/doctor-details.dart';
import 'package:doctor_booking_app/src/model/router_data.dart';
import 'package:doctor_booking_app/src/pages/common/common_widgets.dart';
import 'package:doctor_booking_app/src/pages/doctors/manage_doctor.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/Colors.dart';
import 'package:doctor_booking_app/src/utils/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'doctors_details.dart';

class DoctorsList extends StatefulWidget {
  DoctorsList({this.routerData, this.prefs, this.onDoctorCardTap});

  final RouterData routerData;
  final SharedPreferences prefs;
  final Function onDoctorCardTap;

  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  RouterData get routerData => widget.routerData;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    final doctorsNotifier = Provider.of<DoctorsNotifier>(context);
    var isDark = themeChange.isDark(context);
    var themeData = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: TopBar(
          title: 'Doctors',
          leading: null,
        ),
        floatingActionButton: Align(
          child: FloatingActionButton.extended(
            onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ManageDoctor(doctorDetails: null, routerData: routerData,)
            ))
            },
            label: Text(
              'Add'.toUpperCase(),
              style: themeData.textTheme.button.copyWith(color: Colors.black),
            ),
            icon: Icon(
              MdiIcons.plus,
            ),
            backgroundColor: themeData.accentColor,
            foregroundColor: Colors.black,
          ),
          alignment: Alignment(1, 0),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: FutureBuilder(
          future: doctorsNotifier.streamDoctors(routerData.loggedInUserId),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
              var doctorsList = snapshot.data.docs
                  .map((item) => DoctorDetails.fromMap(item.data(), item.id))
                  .toList();
              return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  padding: EdgeInsets.all(10.0),
                  children: List.generate(
                      doctorsList.length,
                      (index) => GridOptions(
                            doctorDetails: doctorsList[index],
                            onTapCallback: (docs) => gotoDoctorDetailPage(docs),
                          )));
            } else if (snapshot.hasData && snapshot.data.docs.isEmpty) {
              return Center(
                child: CommonWidgets.unAvailableWidget(
                    MdiIcons.doctor,
                    'No Doctors Detail Found',
                    isDark,
                    themeData.accentColor,
                    themeData.primaryColor),
              );
            }
            return CommonWidgets.loadingIndicator(context, isDark,
                title: 'Loading...');
          },
        ));
  }

  void gotoDoctorDetailPage(DoctorDetails doctorsList) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DoctorsDetails(doctorDetails: doctorsList,)
    ));
  }
}

class GridOptions extends StatelessWidget {
  GridOptions({this.doctorDetails, this.onTapCallback});

  final DoctorDetails doctorDetails;
  final Function onTapCallback;

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
            height: 210,
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
                                onTapCallback(doctorDetails);
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
                                            child: Text(
                                                doctorDetails.name.substring(
                                                    0, 1),
                                                style: textTheme.headline4
                                                    .copyWith(
                                                        color: isDark
                                                            ? primaryColor
                                                            : Colors.white)),
                                            backgroundColor: isDark
                                                ? accentColor
                                                : primaryColor,
                                            radius: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        doctorDetails.name,
                                        style: textTheme.subtitle1.copyWith(
                                            color: isDark
                                                ? accentColor.withOpacity(0.9)
                                                : primaryColor,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      doctorDetails.speciality,
                                      style: textTheme.subtitle2.copyWith(
                                          color: isDark
                                              ? accentColor.withOpacity(0.9)
                                              : primaryColor,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.access_time,
                                            size: 18,
                                          ),
                                        ),
                                        Text(
                                          '${doctorDetails.timingStart}-${doctorDetails.timingEnd}',
                                          style: textTheme.subtitle2.copyWith(
                                              color: isDark
                                                  ? accentColor.withOpacity(0.9)
                                                  : primaryColor,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
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
