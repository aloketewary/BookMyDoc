import 'package:doctor_booking_app/src/database/firestore.dart';

class DoctorsDataApi extends FireStoreApi {
  DoctorsDataApi() : super(doctorsApi);
  static final String doctorsApi = 'doctors'; // Our collections path name

}
