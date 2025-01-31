import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uperks/constants/user_type.dart';

class MyFireBase {
  static bool isAuth = FirebaseAuth.instance.currentUser == null;
  static final db = FirebaseFirestore.instance;
  static User? user = FirebaseAuth.instance.currentUser;

  static Future<void> _addUser(String uid, String name, String email,
      String phoneNumber, UserType userType) {
    return db.collection("users").doc(uid).set({
      'name': name,
      'email': email,
      'userType': userType.name.toString(),
      'phoneNumber': phoneNumber,
    });
  }

  static Future<bool> signInWithGoogle() async {
    if (isAuth) {
      return true;
    }
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: ["email"]).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      isAuth = true;

      await _addUser(user!.uid, user!.displayName!, user!.email!, "0000000000",
          UserType.customer);

      return true;
    } catch (e) {
      return false;
    }
  }


}
