import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uperks/constants/user_type.dart';
import 'package:uperks/models/user_model.dart';

enum SignInStatus {
  error,
  ok,
  sellerDataNotFound,
}

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

      if (_user!.userType == UserType.seller) {
        if (_user!.upiId == null ||
            _user!.upiId == "null" ||
            _user!.upiId == "") {
          return false;
        }
      }
      return true;
    } else if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<SignInStatus> signInWithGoogle(UserType userType) async {
    if (isAuth) {
      return SignInStatus.ok;
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
        final userData =
            (await _db.collection("users").doc(creduser!.uid).get());

        isAuth = true;
        if (userData.exists) {
          _user = UserModel.fromFirestore(userData, null);
          if (_user!.upiId == null ||
              _user!.upiId == "null" ||
              _user!.upiId == "") {
            return SignInStatus.sellerDataNotFound;
          }
        } else {
          _user = UserModel(creduser.uid, creduser.displayName!,
              creduser.email!, creduser.phoneNumber, userType);
          await _db
              .collection("users")
              .doc(_user!.id)
              .set(_user!.toFirestore());
        }

        return SignInStatus.ok;
      } catch (e) {
        print(e);
        return SignInStatus.error;
      }
    }
  }

  UserModel? get user {
    return _user;
  }
}
