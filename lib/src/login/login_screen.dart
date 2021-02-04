import 'dart:ui';

import 'package:doctor_booking_app/src/common/CommonWidgets.dart';
import 'package:doctor_booking_app/src/common/loader_hud.dart';
import 'package:doctor_booking_app/src/service/base/base-auth.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/Colors.dart';
import 'package:doctor_booking_app/src/utils/wave-clipper.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreenPage extends StatefulWidget {
  LoginScreenPage({Key key, this.auth, this.loginCallback}) : super(key: key);

  final BaseAuth auth;
  final Function loginCallback;

  @override
  _LoginScreenPageState createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  final _formKey = GlobalKey<FormState>();
  var isPasswordVisible = false;
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    var _theme = Theme.of(context);
    var _size = MediaQuery.of(context).size;
    var _textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: LoaderHUD(
      inAsyncCall: isLoading,
      child: SingleChildScrollView(
          child: Column(
        children: [
          ClipPath(
            clipper: WaveClipper(flip: true, reverse: false),
            child: Stack(
              children: [
                Container(
                    height: _size.height * 0.6,
                    color: _theme.primaryColor,
                    width: _size.width,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome',
                            style: _textTheme.headline3.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Back',
                            style: _textTheme.headline3.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                ClipPath(
                    clipper: WaveClipper(flip: false, reverse: false),
                    child: Container(
                      height: _size.height * 0.15,
                      color: AppColors.blue2,
                      width: _size.width,
                    )),
                Positioned(
                    top: 10,
                    right: 65,
                    child: CommonWidgets.circularContainer(
                        50,
                        isDark
                            ? AppColors.darkerCard.withOpacity(0.35)
                            : AppColors.blue)),
                Positioned(
                    top: -100,
                    left: -75,
                    child: CommonWidgets.circularContainer(
                        _size.width * .4,
                        isDark
                            ? AppColors.darkCard.withOpacity(0.32)
                            : AppColors.darkBlue)),
                Positioned(
                    top: -120,
                    right: -30,
                    child: CommonWidgets.circularContainer(
                        _size.width * .7, Colors.transparent,
                        borderColor:
                            isDark ? Colors.black54 : AppColors.lightBlue)),
                Positioned(
                    top: -200,
                    right: -30,
                    child: CommonWidgets.circularContainer(
                        _size.width * .7, Colors.transparent,
                        borderColor:
                            isDark ? Colors.black87 : AppColors.lightBlue)),
              ],
            ),
          ),
          _generateForm(context)
        ],
      )),
    ));
  }

  Widget _generateForm(BuildContext context) {
    var _theme = Theme.of(context);
    var _size = MediaQuery.of(context).size;
    var _textTheme = Theme.of(context).textTheme;
    return Container(
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailCtrl,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(MdiIcons.emailOutline),
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        var regex = RegExp(pattern);
                        if (value.isEmpty) {
                          return 'Required';
                        } else if (!regex.hasMatch(value)) {
                          return 'Email must be valid';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                    ),
                    TextFormField(
                      controller: _pwdCtrl,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(MdiIcons.lockOutline),
                          suffixIcon: GestureDetector(
                            onTap: () => setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            }),
                            child: isPasswordVisible
                                ? Icon(MdiIcons.eyeOutline)
                                : Icon(MdiIcons.eyeOffOutline),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isPasswordVisible,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        child: Container(
                          width: _size.width,
                          child: Text(
                            'Forget password?',
                            style: _textTheme.subtitle1
                                .copyWith(color: _theme.primaryColor),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                        width: _size.width,
                        height: 40,
                        child: MaterialButton(
                          color: _theme.primaryColor,
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              // Process data.
                              isLoading = true;
                              widget.auth
                                  .signIn(_emailCtrl.text, _pwdCtrl.text)
                                  .then((value) {
                                isLoading = false;
                                widget.loginCallback(value);
                              }).catchError((onError) {
                                isLoading = false;
                                print(onError);
                              });
                            }
                          },
                          child: Text(
                            'Log in',
                            style: _textTheme.subtitle1
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
