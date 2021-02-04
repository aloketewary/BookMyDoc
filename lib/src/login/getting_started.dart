import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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

  @override
  void initState() {
    super.initState();
    _idCtrl.text = widget.userId.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        title: Text(
          'Just need few more details',
          style: textTheme.headline5.copyWith(
            color: Colors.white,
          ),
        ),
      ),
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
    );
  }

  Widget _buildFormWidget(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 8)),
              TextFormField(
                controller: _idCtrl,
                decoration: InputDecoration(
                    hintText: 'ID',
                    prefixIcon: Icon(MdiIcons.cardAccountDetailsOutline),
                    floatingLabelBehavior: FloatingLabelBehavior.auto
                ),
                readOnly: true,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'DOB can not blank';
                  }
                  return null;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 8)),
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(MdiIcons.accountOutline),
                    floatingLabelBehavior: FloatingLabelBehavior.auto
                ),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Name can not blank';
                  }
                  return null;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 8)),
              TextFormField(
                controller: _dobCtrl,
                decoration: InputDecoration(
                    hintText: 'Date Of Birth',
                    prefixIcon: Icon(MdiIcons.calendar),
                    floatingLabelBehavior: FloatingLabelBehavior.auto
                ),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'DOB can not blank';
                  }
                  return null;
                },
              ),
              Padding(padding: EdgeInsets.only(top: 8)),
              TextFormField(
                controller: _addressCtrl,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: 'Address',
                    prefixIcon: Icon(MdiIcons.mapMarker),
                    floatingLabelBehavior: FloatingLabelBehavior.auto
                ),
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Address can not blank';
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
  }
}
