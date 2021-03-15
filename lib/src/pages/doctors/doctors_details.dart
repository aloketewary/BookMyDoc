import 'dart:math';

import 'package:doctor_booking_app/src/model/doctor-details.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/custom_appbar.dart';
import 'package:doctor_booking_app/src/utils/locations.dart' as locations;
import 'package:doctor_booking_app/src/utils/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DoctorsDetails extends StatefulWidget {
  DoctorsDetails({this.doctorDetails});

  final DoctorDetails doctorDetails;

  @override
  _DoctorsDetailsState createState() => _DoctorsDetailsState();
}

class _DoctorsDetailsState extends State<DoctorsDetails> {
  final Map<String, Marker> _markers = {};
  DoctorDetails get doctorDetails => widget.doctorDetails;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    return Scaffold(
      appBar: TopBar(
        leading: Icons.arrow_back,
        title: 'Detail of ${doctorDetails.name}',
        onPressed: () => Navigator.of(context).pop(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Book Appointment'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAvatarRow(themeData, isDark),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ListTile(
                  leading: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                      )),
                  title: Text(
                    doctorDetails.rating,
                    style: themeData.textTheme.headline6,
                  ),
                  subtitle: Text('Ratings'),
                )),
                Expanded(
                    child: ListTile(
                  leading: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            MdiIcons.stethoscope,
                            color: Colors.blue,
                          ),
                        ),
                      )),
                  title: Text(
                    getCalculatedExp(),
                    style: themeData.textTheme.headline6,
                  ),
                  subtitle: Text('Exp'),
                )),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      'Clinic Fees',
                                      style: themeData.textTheme.caption,
                                    ),
                                  ),
                                  Text(
                                    '₹${doctorDetails.fees}',
                                    style: themeData.textTheme.headline6,
                                  )
                                ])),
                            Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      'Availability',
                                      style: themeData.textTheme.caption,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        size: 18,
                                      ),
                                      Text(
                                        '${doctorDetails.timingStart} - ${doctorDetails.timingEnd}',
                                        style: themeData.textTheme.subtitle1,
                                      ),
                                    ],
                                  )
                                ]))
                          ],
                        ),
                      ))),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.call,
                                color: Colors.green,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.message,
                                color: Colors.blue,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.videocam,
                                color: Colors.amber,
                              ),
                            ),
                          )),
                    ),
                  ]),
            ),
            Container(
                height: 160,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: const LatLng(0, 0),
                              zoom: 2,
                            ),
                            markers: _markers.values.toSet(),
                          ),
                        )))),
          ],
        ),
      ),
    );
  }

  Row buildAvatarRow(ThemeData themeData, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${Random().nextInt(20) + 10}'),
            backgroundColor: Colors.transparent,
            radius: 50,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildColumnText(
                'Dr. ${doctorDetails.name}',
                themeData.textTheme.headline6.copyWith(
                    color: isDark ? themeData.accentColor : themeData.primaryColor, fontWeight: FontWeight.bold)),
            buildColumnText(
                doctorDetails.speciality,
                themeData.textTheme.subtitle1.copyWith(
                  color: isDark ? themeData.accentColor : themeData.primaryColor,
                  fontWeight: FontWeight.normal,
                )),
            buildColumnText(
                doctorDetails.dispensaryId != null ? 'Sterling Multi facility Hospital':'Sterling Multi facility Hospital',
                themeData.textTheme.subtitle1.copyWith(
                    color: isDark ? themeData.accentColor : themeData.primaryColor, fontWeight: FontWeight.normal)),
          ],
        ),
      ],
    );
  }

  Widget buildColumnText(String titleText, TextStyle textStyle) {
    return Padding(
        padding: EdgeInsets.all(2),
        child: Text(
          titleText,
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        ));
  }

  String getCalculatedExp() {
    var difference = DateTime.now().difference(doctorDetails.practiceStartedFrom);
    return (difference.inDays.toDouble() / 365).toStringAsFixed(2);
  }
}
