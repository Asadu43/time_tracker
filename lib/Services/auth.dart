import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;

  Future<User> signInAnonymously();

  Future<void> signOut();

  Stream<User> authStateChange();

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future <User> signInWithEmail(String email, String password);

  Future<User> createAccountWithEmail(String email, String password);

}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User> authStateChange() => _firebaseAuth.authStateChanges();

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return (userCredential.user);
  }
  @override
  Future <User> signInWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password)
    );
    return userCredential.user;
  }
  @override
  Future<User> createAccountWithEmail(String email, String password) async {
    final userCredentail = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredentail.user;
  }

  // SIGN IN WITH GOOGLE
  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredentials = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredentials.user;
      } else {
        throw FirebaseAuthException(
            message: "ERROR_MESSAGE_GOOGLE_ID_TOKEN",
            code: "Google token id missing");
      }
    } else {
      throw FirebaseAuthException(
          message: "ERROR_ABORT_BY USER", code: "SIGN In Abort by User");
    }
  }

  // SIGN IN WITH FACEBOOK
  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token));
        return userCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
            message: "ERROR_ABORT_BY USER", code: "SIGN In Abort by User");
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
            message: "ERROR FACEBOOK LOGIN FAILED",
            code: response.error.developerMessage);
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    //Google Logout Code
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();


    //Facebook Logout Code
    final facebooklogin = FacebookLogin();
    await facebooklogin.logOut();

    await _firebaseAuth.signOut();
  }
}
