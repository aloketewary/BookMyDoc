import 'package:flutter/cupertino.dart';

class SpecialityModel {
  SpecialityModel(
      {this.imgAssetPath,
      this.speciality,
      this.noOfDoctors,
      this.backgroundColor});

  String imgAssetPath;
  String speciality;
  int noOfDoctors;
  Color backgroundColor;
}
