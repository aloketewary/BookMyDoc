import 'package:doctor_booking_app/src/database/firestore.dart';

class UsersDataApi extends FireStoreApi {
  UsersDataApi() : super(usersApi);
  static final String usersApi = 'users'; // Our collections path name

}
