import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuth {
  final fireAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn.instance;

  Future<UserCredential> signInWithGoogle() async {
    await googleSignIn.initialize(
      serverClientId:
          "514060904122-4igqe3j6022qs1se2nmq9ur5pk1dnpjm.apps.googleusercontent.com",
    );
    GoogleSignInAccount googleSignInAccount = await googleSignIn.authenticate();
    GoogleSignInAuthentication googleSignInAuthentication =
        googleSignInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential userCredential = await fireAuth.signInWithCredential(
      authCredential,
    );
    return userCredential;
  }

  Future<void> signOut() async {
    try {
      await fireAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      debugPrint("sign out error");
    }
  }
}
