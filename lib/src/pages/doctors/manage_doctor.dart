import 'package:doctor_booking_app/src/database/notifier/doctors_notifier.dart';
import 'package:doctor_booking_app/src/database/notifier/users_notifier.dart';
import 'package:doctor_booking_app/src/enums/gender_enum.dart';
import 'package:doctor_booking_app/src/model/doctor-details.dart';
import 'package:doctor_booking_app/src/model/router_data.dart';
import 'package:doctor_booking_app/src/pages/common/common_widgets.dart';
import 'package:doctor_booking_app/src/themes/styles.dart';
import 'package:doctor_booking_app/src/themes/theme_provider.dart';
import 'package:doctor_booking_app/src/utils/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ManageDoctor extends StatefulWidget {
  ManageDoctor({this.doctorDetails, this.routerData});

  final DoctorDetails doctorDetails;
  final RouterData routerData;

  @override
  _ManageDoctorState createState() => _ManageDoctorState();
}

class _ManageDoctorState extends State<ManageDoctor> {
  DoctorDetails get doctorDetails => widget.doctorDetails;
  RouterData get routerData => widget.routerData;

  bool get isEdit => widget.doctorDetails != null;
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  var _selectedDate = DateTime.now();
  final _mobileCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _feesCtrl = TextEditingController();
  final _psFromCtrl = TextEditingController();
  final _startTimeCtrl = TextEditingController();
  GenderEnum _gender = GenderEnum.male;
  bool isFormSubmissionStarted = false;
  var _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final themeChange = Provider.of<ThemeProvider>(context);
    var isDark = themeChange.isDark(context);
    return Scaffold(
      appBar: TopBar(
        leading: Icons.arrow_back,
        title: isEdit ? 'Edit ${doctorDetails.name}' : 'Add Doctor',
        onPressed: () => Navigator.of(context).pop(),
      ),
      floatingActionButton: Visibility(
        visible: _formKey.currentState?.validate() != null &&
            _formKey.currentState.validate(),
        child: FloatingActionButton.extended(
            onPressed: () {
              setState(
                      () => isFormSubmissionStarted = !isFormSubmissionStarted);
              _formSubmit(null);
            },
            label: Text(isEdit ? 'UPDATE' : 'ADD')),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  Visibility(
                    visible: isEdit,
                    child: CommonWidgets.inputFormField(_idCtrl, 'ID',
                            (val) => emptyValidator(val, 'ID'), isDark,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        prefixIcon: MdiIcons.cardAccountDetailsOutline),
                  ),
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
                          () =>
                          CommonWidgets.selectDate(
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
                          .map((value) =>
                          DropdownMenuItem(
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
                  CommonWidgets.inputFormField(_emailCtrl, 'Email',
                          (val) => emptyValidator(val, 'Email'), isDark,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: MdiIcons.email),
                  CommonWidgets.textBoxFormField(_addressCtrl, 'Address',
                          (val) => emptyValidator(val, 'Address'), isDark,
                      textCapitalization: TextCapitalization.words,
                      prefixIcon: MdiIcons.mapMarker),
                  CommonWidgets.inputFormField(_feesCtrl, 'Fees',
                          (val) => emptyValidator(val, 'Fees'), isDark,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.number,
                      prefixIcon: MdiIcons.cash),
                  CommonWidgets.dateInputFormField(
                      _psFromCtrl,
                      'Practise started from',
                          (val) => emptyValidator(val, 'Practise started from'),
                      isDark, () =>
                          CommonWidgets.selectDate(
                              context, _dobCtrl, (val) => pickedValue(val),
                              selectedDate: _selectedDate,
                              isDark: isDark,
                              themeData: themeData),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      prefixIcon: MdiIcons.calendar),
                  CommonWidgets.timeInputFormField(
                      _dobCtrl,
                      'Start Timing',
                          (val) => emptyValidator(val, 'Start Timing'),
                      isDark,
                          () =>
                          CommonWidgets.selectTime(
                              context, _startTimeCtrl, (val) => pickedTimeValue(val, _startTimeCtrl),
                              selectedTime: _selectedTime,
                              isDark: isDark,
                              themeData: themeData),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      prefixIcon: MdiIcons.timeline),
                  CommonWidgets.timeInputFormField(
                      _dobCtrl,
                      'End Timing',
                          (val) => emptyValidator(val, 'End Timing'),
                      isDark,
                          () =>
                          CommonWidgets.selectTime(
                              context, _startTimeCtrl, (val) => pickedTimeValue(val, _startTimeCtrl),
                              selectedTime: _selectedTime,
                              isDark: isDark,
                              themeData: themeData),
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      prefixIcon: MdiIcons.timeline),
                ]))),
      ),
    );
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

  void pickedTimeValue(TimeOfDay value, TextEditingController ctrl) {
    setState(() {
      _selectedTime = value;
        var _hour = _selectedTime.hour.toString();
        var _minute = _selectedTime.minute.toString();
        var _time = _hour + ' : ' + _minute;
        ctrl.text = _time;
      // ctrl.text = DateFormat(
      //       DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
      //       [hh, ':', nn, ' ', am]).toString();
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

  void _formSubmit(DoctorsNotifier _doctorsNotifier) {
    _formKey.currentState.save();
    var _doctorDetails = DoctorDetails(
      id: '',
      dob: DateFormat('dd-MM-yyyy').parse(_dobCtrl.text),
      email: _emailCtrl.text.trim(),
      mobile: _mobileCtrl.text.trim(),
      name: _nameCtrl.text.trim(),
      gender: _gender,
      address: _addressCtrl.text.trim(),
      dispensaryId: routerData.loggedInUserId,
      fees: _feesCtrl.text.trim(),
      practiceStartedFrom: DateFormat('dd-MM-yyyy').parse(_psFromCtrl.text),
      rating: '0',
      speciality: '',
      timingEnd: '',
      timingStart: '',
    );
    _doctorsNotifier.createNewDoctors('', _doctorDetails)
    .then((docDetails){
      if (docDetails != null) {
            setState(() => isFormSubmissionStarted = !isFormSubmissionStarted);
            // Fluttertoast.showToast(msg: 'Welcome ' + _teNameCtrl.text);
            // SharedPreferencesHelper.setLoggedUserData(_user, widget.prefs);
            // widget.checkFirstTimeUserCallback();
          }
      }).catchError((error) {
      setState(() => isFormSubmissionStarted = false);
      });
  }
}
