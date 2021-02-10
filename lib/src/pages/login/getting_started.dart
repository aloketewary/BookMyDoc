import 'package:doctor_booking_app/src/common/common_widgets.dart';
import 'package:doctor_booking_app/src/common/loader_hud.dart';
import 'package:doctor_booking_app/src/database/notifier/users_notifier.dart';
import 'package:doctor_booking_app/src/enums/gender_enum.dart';
import 'package:doctor_booking_app/src/model/user-details.dart';
import 'package:doctor_booking_app/src/service/shared/shared-prefernces-helper.dart';
import 'package:doctor_booking_app/src/themes/styles.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GettingStarted extends StatefulWidget {
  GettingStarted(
      {this.userId, this.email, this.checkFirstTimeUserCallback, this.prefs});

  final String userId;
  final String email;
  final Function checkFirstTimeUserCallback;
  final SharedPreferences prefs;

  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _idCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  GenderEnum _gender = GenderEnum.male;
  bool isFormSubmissionStarted = false;

  @override
  void initState() {
    super.initState();
    _idCtrl.text = widget.userId.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var _usersNotifier = Provider.of<UsersNotifier>(context);
    return LoaderHUD(
        inAsyncCall: isFormSubmissionStarted,
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 10,
            title: Text(
              'Just need few more details',
              style: textTheme.headline5.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: _formKey.currentState?.validate() != null &&
                _formKey.currentState.validate(),
            child: FloatingActionButton.extended(
                onPressed: () {
                  setState(
                      () => isFormSubmissionStarted = !isFormSubmissionStarted);
                  _formSubmit(_usersNotifier);
                },
                label: Text('SAVE')),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 45,
                      ),
                    ),
                    _buildFormWidget(context)
                  ],
                )),
          ),
        ));
  }

  Widget _buildFormWidget(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    var _size = MediaQuery.of(context).size;
    var themeData = Theme.of(context);
    var _textTheme = Theme.of(context).textTheme;
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CommonWidgets.inputFormField(
                  _idCtrl, 'ID', (val) => emptyValidator(val, 'ID'), isDark,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  prefixIcon: MdiIcons.cardAccountDetailsOutline),
              CommonWidgets.inputFormField(_nameCtrl, 'Name',
                  (val) => emptyValidator(val, 'Name'), isDark,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  prefixIcon: MdiIcons.accountOutline),
              CommonWidgets.dateInputFormField(
                  _dobCtrl,
                  'Date Of Birth',
                  (val) => emptyValidator(val, 'DOB'),
                  isDark,
                  () => CommonWidgets.selectDate(
                      context, _dobCtrl, (val) => pickedValue(val),
                      selectedDate: _selectedDate,
                      isDark: isDark,
                      themeData: themeData),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  prefixIcon: MdiIcons.calendar),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: DropdownButtonFormField(
                  items: GenderEnum.values
                      .where((gender) => gender != GenderEnum.unavailable)
                      .map((value) => DropdownMenuItem(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  getGenderIcons(value),
                                  color: Styles.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5),
                                ),
                                Text(GenderType.toStringData[value])
                              ],
                            ),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (GenderEnum value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  isExpanded: true,
                  value: _gender,
                  hint: Text('Select your gender'),
                  // underline: Container(),
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    prefixIcon: Icon(MdiIcons.genderMaleFemaleVariant),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: CommonWidgets.getBorderColor(isDark)),
                    ),
                  ),
                ),
              ),
              CommonWidgets.inputFormField(_mobileCtrl, 'Mobile',
                  (val) => emptyValidator(val, 'Mobile'), isDark,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  prefixIcon: MdiIcons.phone),
              CommonWidgets.textBoxFormField(_addressCtrl, 'Address',
                  (val) => emptyValidator(val, 'Address'), isDark,
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: MdiIcons.mapMarker),
            ],
          ),
        ));
  }

  String emptyValidator(String value, String validationFor) {
    if (value.isEmpty) {
      return '$validationFor can not be blank';
    }
    return null;
  }

  void pickedValue(DateTime value) {
    setState(() {
      _selectedDate = value;
      _dobCtrl.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
    });
  }

  IconData getGenderIcons(GenderEnum value) {
    switch (value) {
      case GenderEnum.male:
        return MdiIcons.genderMale;
      case GenderEnum.female:
        return MdiIcons.genderFemale;
      case GenderEnum.others:
        return MdiIcons.genderTransgender;
      default:
        return MdiIcons.genderMaleFemale;
    }
  }

  void _formSubmit(UsersNotifier _usersNotifier) {
    _formKey.currentState.save();
    var _user = UserDetails(
        id: '',
        dob: DateFormat('dd-MM-yyyy').parse(_dobCtrl.text),
        email: widget.email,
        mobile: _mobileCtrl.text.trim(),
        name: _nameCtrl.text.trim(),
        gender: _gender,
        address: _addressCtrl.text.trim(),
        dialCode: '+91');
    _usersNotifier.createNewUser(widget.userId, _user).then((userDetail) {
      if (userDetail != null) {
        setState(() => isFormSubmissionStarted = !isFormSubmissionStarted);
        // Fluttertoast.showToast(msg: 'Welcome ' + _teNameCtrl.text);
        SharedPreferencesHelper.setLoggedUserData(_user, widget.prefs);
        widget.checkFirstTimeUserCallback();
      }
    }).catchError((error) {
      setState(() => isFormSubmissionStarted = false);
    });
  }
}
