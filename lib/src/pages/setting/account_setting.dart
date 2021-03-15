import 'package:doctor_booking_app/src/model/router_data.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSetting extends StatelessWidget {
  AccountSetting({this.routerData, this.prefs, this.onDoctorCardTap});

  final RouterData routerData;
  final SharedPreferences prefs;
  final Function onDoctorCardTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(MdiIcons.email),
            ),
            title: Text('Email'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(MdiIcons.bell),
            ),
            title: Text('Notification'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(MdiIcons.lock),
            ),
            title: Text('Privacy'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(MdiIcons.security),
            ),
            title: Text('Security'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              child: Icon(MdiIcons.moonFirstQuarter),
            ),
            title: Text('Display Mode'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(MdiIcons.translate),
            ),
            title: Text('Language'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(MdiIcons.sizeL),
            ),
            title: Text('Text Size'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              child: Icon(MdiIcons.faceAgent),
            ),
            title: Text('Contact'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(MdiIcons.bookOpen),
            ),
            title: Text('Terms of Service'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
