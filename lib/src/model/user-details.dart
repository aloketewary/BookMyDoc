class UserDetails {
  UserDetails({this.id});

  UserDetails.fromMap(Map snapshot, String documentId) {
    id = documentId;
  }

  String id;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
