import 'package:doctor_booking_app/src/enums/gender_enum.dart';
import 'package:intl/intl.dart';

class DoctorDetails {
  DoctorDetails(
      {this.id,
      this.dob,
      this.email,
      this.mobile,
      this.name,
      this.gender,
      this.rating,
      this.dispensaryId,
      this.practiceStartedFrom,
      this.fees,
      this.timingStart,
      this.timingEnd,
      this.address,
      this.speciality});

  DoctorDetails.fromMap(Map snapshot, String documentId) {
    id = documentId;
    name = snapshot['name'];
    email = snapshot['email'];
    mobile = snapshot['mobile'];
    dob = DateFormat('dd-MM-yyyy').parse(snapshot['dob']);
    address = snapshot['address'];
    rating = snapshot['rating'];
    gender = snapshot['gender'] != null && snapshot['gender'] != ''
        ? GenderType.fromDBString[snapshot['gender']]
        : GenderEnum.unavailable;
    dispensaryId = snapshot['dispensary_id'];
    practiceStartedFrom = DateFormat('dd-MM-yyyy').parse(snapshot['practice_started_from']);
    fees = snapshot['fees'];
    timingStart = snapshot['timing_start'];
    timingEnd = snapshot['timing_end'];
    speciality = snapshot['speciality'];
  }

  String id;
  DateTime dob;
  String email;
  String mobile;
  String name;
  GenderEnum gender;
  String rating;
  String address;
  String dispensaryId;
  DateTime practiceStartedFrom;
  String fees;
  String timingStart;
  String timingEnd;
  String speciality;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['dob'] = DateFormat('dd-MM-yyyy').format(dob);
    data['address'] = address;
    data['rating'] = rating;
    data['gender'] = GenderType.toDBStringData[gender];
    data['dispensary_id'] = dispensaryId;
    data['practice_started_from'] = practiceStartedFrom;
    data['fees'] = fees;
    data['timing_start'] = timingStart;
    data['timing_end'] = timingEnd;
    data['speciality'] = speciality;
    return data;
  }
}
