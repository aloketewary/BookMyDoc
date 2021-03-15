import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_app/src/database/doctors_data_api.dart';
import 'package:doctor_booking_app/src/database/users_data_api.dart';
import 'package:doctor_booking_app/src/model/user-details.dart';
import 'package:flutter/material.dart';

class DoctorsNotifier extends ChangeNotifier {
  DoctorsNotifier(DoctorsDataApi api) {
    _api = api;
  }

  DoctorsDataApi _api;

  Future<QuerySnapshot> streamDoctors(String shopId)  {
    return _api.streamDoctorCollection(shopId);
  }

  Future<UserDetails> createNewDoctors(String id, UserDetails user) async {
    Map data = user.toJson();
    await _api.addUsersDocument(id, data);
    return UserDetails.fromMap(data, id);
  }

  Future<QuerySnapshot> streamUsersByBloodGroup(String city) {
    city = city.toLowerCase().trim().replaceAll(' ', '_');
    return _api.streamSearchUserCollection(city);
  }

  Future<QuerySnapshot> getSingleDoctorsCollection(String uid) {
    return _api.getSingleUserCollection(uid);
  }

  Future<UserDetails> updateDoctorsDetails(UserDetails userDetails) async {
    Map data = userDetails.toJson();
    await _api.updateDocument(userDetails.id, data);
    return UserDetails.fromMap(data, userDetails.id);
  }

  Future<UserDetails> deleteUser(UserDetails event) async {
    Map data = event.toJson();
    await _api.deleteDocument(event.id);
    return UserDetails.fromMap(data, event.id);
  }

  Future<UserDetails> getSingleDoctorsDetails(String number) async {
    var document = await _api.getSingleUserCollection(number);
    if (document != null && document.docs.isNotEmpty) {
      DocumentSnapshot _documentSnapshot = document.docs.elementAt(0);
      return UserDetails.fromMap(
          _documentSnapshot.data(), _documentSnapshot.id);
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
