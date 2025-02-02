import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uperks/constants/user_type.dart';
import 'package:uperks/models/user_model.dart';

class MyFireBaseAuth with ChangeNotifier {
  static bool isAuth = (FirebaseAuth.instance.currentUser != null);
  static final _db = FirebaseFirestore.instance;
  static MyFireBaseAuth? _instance;
  static UserModel? _user;

  factory MyFireBaseAuth() {
    _instance ??= MyFireBaseAuth._init();
    return _instance!;
  }
  MyFireBaseAuth._init();

  Future<bool> updateUser() async {
    if (isAuth && user == null) {
      final result = await _db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      _user = UserModel.fromFirestore(result, null);

      notifyListeners();
      return true;
    } else if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> signInWithGoogle() async {
    if (isAuth) {
      return true;
    } else {
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
        var creduser =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        _user = UserModel(creduser!.uid, creduser.displayName!, creduser.email!,
            creduser.phoneNumber, UserType.customer);
        await _db.collection("users").doc(_user!.id).set(_user!.toFirestore());
        isAuth = true;

        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }
  }

  UserModel? get user {
    return _user;
  }
}
