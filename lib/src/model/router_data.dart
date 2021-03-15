import 'package:doctor_booking_app/src/model/user-details.dart';

class RouterData {
  RouterData({this.userDetails, this.loggedInUserId});

  UserDetails userDetails;
  String loggedInUserId;
}
