import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
 Future<String> signIn(String email, String password);

 Future<String> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  // Future<GoogleSignInAccount> getSignedInAccount(GoogleSignIn googleSignIn);

  // Future<FirebaseUser> signIntoFirebase(GoogleSignInAccount googleSignInAccount);

  // Future<String> signInWithGoogle();

  void signOutGoogle();

  Future<bool> isUserLoggedIn();

  void signOutFromFireBase();

  Future<User> signInWithCredential(AuthCredential credential);
}
