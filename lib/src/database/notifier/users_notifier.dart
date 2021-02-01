import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_app/src/database/users_data_api.dart';
import 'package:doctor_booking_app/src/model/user-details.dart';
import 'package:flutter/material.dart';

class UsersNotifier extends ChangeNotifier {
  UsersNotifier(UsersDataApi api) {
    _api = api;
  }
  UsersDataApi _api;

  Future<QuerySnapshot> streamUsers(List<String> numbers) {
    return _api.streamUserCollection(numbers);
  }

  Future<UserDetails> createNewUser(String id, UserDetails user) async {
    Map data = user.toJson();
    await _api.addUsersDocument(id, data);
    return UserDetails.fromMap(data, id);
  }

  Future<QuerySnapshot> streamUsersByBloodGroup(String city) {
    city = city.toLowerCase().trim().replaceAll(' ', '_');
    return _api.streamSearchUserCollection(city);
  }

  Future<QuerySnapshot> getSingleUserCollection(String number) {
    return _api.getSingleUserCollection(number);
  }

  Future<UserDetails> updateUserDetails(UserDetails userDetails) async {
    Map data = userDetails.toJson();
    await _api.updateDocument(userDetails.id, data);
    return UserDetails.fromMap(data, userDetails.id);
  }

  Future<UserDetails> deleteUser(UserDetails event) async {
    Map data = event.toJson();
    await _api.deleteDocument(event.id);
    return UserDetails.fromMap(data, event.id);
  }

  Future<UserDetails> getSingleUserDetails(String number) async {
    var document = await _api.getSingleUserCollection(number);
    if (document != null && document.docs.isNotEmpty) {
      DocumentSnapshot _documentSnapshot = document.docs.elementAt(0);
      return UserDetails.fromMap(_documentSnapshot.data(), _documentSnapshot.id);
    }
    return null;
  }

  Future<void> updateDonationDate(String userId, Map userDetailsList) async {
    await _api.updateUserDonationDate(userId, userDetailsList);
  }

   Stream<DocumentSnapshot> getDataById(String id) {
     return _api.getDataById(id);
  }
}
