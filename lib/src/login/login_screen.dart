import 'package:doctor_booking_app/src/service/base/base-auth.dart';
import 'package:flutter/material.dart';

class LoginScreenPage extends StatefulWidget {
  LoginScreenPage({Key key, this.auth, this.loginCallback}) : super(key: key);

  final BaseAuth auth;
  final Function loginCallback;

  @override
  _LoginScreenPageState createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
