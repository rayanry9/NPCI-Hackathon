import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uperks/constants/user_type.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/models/user_model.dart';
import 'package:uperks/services/firebase_transactions.dart';

enum SignInStatus { error, ok, sellerDataNotFound, wrongSignIn }

class MyFireBaseAuth with ChangeNotifier {
  static bool isAuth = (FirebaseAuth.instance.currentUser != null);
  static final _db = FirebaseFirestore.instance;
  static MyFireBaseAuth? _instance;
  static UserModel? _user;
  static int? _customerRedeemRate;
  static int? _sellerBuyRate;

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
        if (_user!.phoneNumber == null ||
            _user!.phoneNumber == "null" ||
            _user!.phoneNumber == "") {
          return false;
        }
      }
      _customerRedeemRate =
          (await _db.collection("constants").doc("rates").get())
              .data()?["customerRedeem"];
      _sellerBuyRate = (await _db.collection("constants").doc("rates").get())
          .data()?["sellerBuy"];

      return true;
    } else if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateUserData({
    String? name,
    String? email,
    String? phoneNumber,
    String? profilePicUrl,
    String? upiId,
  }) async {
    (await _db.collection("users").doc(MyFireBaseAuth().user!.id).update(
        UserModel.toFirestoreForUpdate(
            name: name,
            phoneNumber: phoneNumber,
            profilePicUrl: profilePicUrl,
            upiId: upiId)));
  }

  static Future<SignInStatus> signInWithGoogle(UserType userType) async {
    if (isAuth) {
      return SignInStatus.ok;
    } else {
      try {
        final GoogleSignIn signIn = GoogleSignIn(scopes: ["email"]);
        final GoogleSignInAccount? googleUser = await signIn.signIn();

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
          if (_user!.userType != userType) {
            isAuth = false;
            _user = null;
            await FirebaseAuth.instance.signOut();
            await signIn.disconnect();

            return SignInStatus.wrongSignIn;
          }
          if ((_user!.phoneNumber == null ||
                  _user!.phoneNumber == "null" ||
                  _user!.phoneNumber == "") &&
              userType == UserType.seller) {
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

        _customerRedeemRate =
            (await _db.collection("constants").doc("rates").get())
                .data()?["customerRedeem"];
        _sellerBuyRate = (await _db.collection("constants").doc("rates").get())
            .data()?["sellerBuy"];
        if (userType == UserType.seller) {
          return SignInStatus.sellerDataNotFound;
        }

        return SignInStatus.ok;
      } catch (e) {
        print(e);
        isAuth = false;
        return SignInStatus.error;
      }
    }
  }

  UserModel? get user {
    return _user;
  }

  static int? get customerRedeemRate {
    return _customerRedeemRate;
  }

  static int? get sellerBuyRate {
    return _sellerBuyRate;
  }
}
