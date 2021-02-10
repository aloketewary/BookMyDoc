import 'package:doctor_booking_app/src/service/base/base-auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/auth_credential.dart';

class BookMyDocAuth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> getCurrentUser() async {
    var user = await _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    var user = await _firebaseAuth.currentUser;
    await user.sendEmailVerification();
  }

  @override
  Future<bool> isEmailVerified() async {
    var user = await _firebaseAuth.currentUser;
    return user.emailVerified;
  }

  @override
  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser;
    return user != null;
  }

  @override
  void signOutFromFireBase() async {
    try {
      // sign out code
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<User> signInWithCredential(AuthCredential credential) async {
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final currentUser = await _firebaseAuth.currentUser;
    assert(user.uid == currentUser.uid);
    return user;
  }

  @override
  Future<String> signIn(String email, String password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    var user = result.user;
    return user.uid;
  }

  @override
  void signOutGoogle() {
    // TODO: implement signOutGoogle
  }

  @override
  Future<String> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
