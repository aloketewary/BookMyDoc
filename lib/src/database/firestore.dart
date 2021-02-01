import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreApi {
  FireStoreApi(String collectionPath) {
    _collectionReference = _fireStore.collection(collectionPath);
  }
  final _fireStore = FirebaseFirestore.instance;
  CollectionReference _collectionReference;

  Stream<QuerySnapshot> streamCollection(String city) {
    return _collectionReference.where('city_id', isEqualTo: city).snapshots();
  }

  Future<QuerySnapshot> streamUserCollection(List<String> number) {
    return _collectionReference.where('mobile', whereIn: number).get();
  }

  Future<QuerySnapshot> streamSearchUserCollection(String city) {
    return _collectionReference
        // .where('blood_group', isEqualTo: bloodGroup)
        .where('city_id', isEqualTo: city)
        .get();
  }

  Future<QuerySnapshot> getCollection() {
    return _collectionReference.get();
  }

  Future<DocumentReference> addEventsDocument(Map data) {
    return _collectionReference.add(data);
  }

  Future<void> addUsersDocument(String id, Map data) {
    return _collectionReference.doc(id).set(data);
  }

  Future<void> updateDocument(String id, Map data) {
    return _collectionReference.doc(id).update(data);
  }

  Future<void> deleteDocument(String id) {
    return _collectionReference.doc(id).delete();
  }

  Future<DocumentSnapshot> getEventsCollection(String city) {
    return _collectionReference.doc(city).get();
  }

  Stream<DocumentSnapshot> streamEventCollection(String city) {
    return _collectionReference.doc(city).snapshots();
  }

  Future<QuerySnapshot> getSingleUserCollection(String number) {
    return _collectionReference
        .where('mobile', isEqualTo: number)
        .get();
  }

  Stream<QuerySnapshot> streamAllPendingEventCollection(String type) {
    return _collectionReference.where('status', isEqualTo: type).snapshots();
  }

  Future<DocumentReference> addDocument(Map data) {
    return _collectionReference.add(data);
  }

  Stream<QuerySnapshot> streamRequestsForCurrentUser(String uid) {
    return _collectionReference
        .where('created_by_id', isEqualTo: uid)
        .snapshots();
  }

  Future<QuerySnapshot> futureRequestsForCurrentUser(String uid) {
    return _collectionReference
        .where('created_by_id', isEqualTo: uid)
        .get();
  }

  Stream<DocumentSnapshot> streamCurrentBloodRequest(String id) {
    return _collectionReference.doc(id).snapshots();
  }

  Future<void> addDonorDetails(
      String bloodReqId, Map data, int currentlyDonate) {
    final userDetailsList = <String, dynamic>{
      'user_donated_list': FieldValue.arrayUnion([data]),
      'completed_units': currentlyDonate
    };
    return _collectionReference
        .doc(bloodReqId)
        .set(userDetailsList, SetOptions(merge: true));
  }

  Future<void> updateUserDonationDate(String userId, Map userDetailsList) {
    return _collectionReference
        .doc(userId)
        .set(userDetailsList, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot> getDataById(String id) {
    return _collectionReference.doc(id).snapshots();
  }

  Future<QuerySnapshot> fetchDonationHistoryWhereUserId(String userId) {
    return _collectionReference.where('donor_id', isEqualTo: userId).get();
  }
}
