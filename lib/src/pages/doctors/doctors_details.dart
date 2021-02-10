import 'package:doctor_booking_app/src/utils/custom_appbar.dart';
import 'package:doctor_booking_app/src/utils/locations.dart' as locations;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DoctorsDetails extends StatefulWidget {
  @override
  _DoctorsDetailsState createState() => _DoctorsDetailsState();
}

class _DoctorsDetailsState extends State<DoctorsDetails> {
  final Map<String, Marker> _markers = {};

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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: BmdAppBar(
        leading: Icons.arrow_back,
        title: '',
        onPressed: () => Navigator.of(context).pop(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {  },
        label: Text('Book Appointment'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAvatarRow(textTheme),
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
                    '4.5',
                    style: textTheme.headline6,
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
                    '5 years',
                    style: textTheme.headline6,
                  ),
                  subtitle: Text('Experience'),
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
                                      style: textTheme.caption,
                                    ),
                                  ),
                                  Text(
                                    '₹250',
                                    style: textTheme.headline6,
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
                                      style: textTheme.caption,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        size: 18,
                                      ),
                                      Text(
                                        '10:30am - 2:30pm',
                                        style: textTheme.subtitle1,
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

  Row buildAvatarRow(TextTheme textTheme) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=23'),
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
                "Dr. Stephen Strange",
                textTheme.headline6.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            buildColumnText(
                "Neuro Surgen Speciality",
                textTheme.subtitle1.copyWith(
                  color: Colors.black45,
                  fontWeight: FontWeight.normal,
                )),
            buildColumnText(
                "Sterling Multi facility Hospital",
                textTheme.subtitle1.copyWith(
                    color: Colors.black45, fontWeight: FontWeight.normal)),
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
}
