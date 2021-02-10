import 'package:doctor_booking_app/src/enums/gender_enum.dart';
import 'package:intl/intl.dart';

class UserDetails {
  UserDetails(
      {this.id,
      this.dob,
      this.email,
      this.mobile,
      this.name,
      this.gender,
      this.dialCode,
      this.address});

  UserDetails.fromMap(Map snapshot, String documentId) {
    id = documentId;
    name = snapshot['name'];
    email = snapshot['email'];
    mobile = snapshot['mobile'];
    dob = DateFormat('dd-MM-yyyy').parse(snapshot['dob']);
    address = snapshot['address'];
    role = snapshot['role'];
    gender = snapshot['gender'] != null && snapshot['gender'] != ''
        ? GenderType.fromDBString[snapshot['gender']]
        : GenderEnum.unavailable;
    dialCode = snapshot['dial_code'] != null && snapshot['dial_code'] != ''
        ? snapshot['dial_code']
        : '+91';
  }

  String id;
  DateTime dob;
  String email;
  String mobile;
  String name;
  GenderEnum gender;
  String dialCode;
  String address;
  String role;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['dob'] = DateFormat('dd-MM-yyyy').format(dob);
    data['address'] = address;
    data['role'] = null;
    data['gender'] = GenderType.toDBStringData[gender];
    data['dial_code'] = dialCode ?? '+91';
    return data;
  }
}
