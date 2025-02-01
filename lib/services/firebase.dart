import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uperks/constants/user_type.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/models/user_model.dart';

class MyFireBase extends ChangeNotifier {
  static bool isAuth = (FirebaseAuth.instance.currentUser != null);
  static final db = FirebaseFirestore.instance;
  static UserModel? user;
  static List<TransactionModel> _transactions = [];

  static Future<void> _addUser(UserModel user) {
    return db.collection("users").doc(user.id).set(user.toFirestore());
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
      var creduser =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      user = UserModel(creduser!.uid, creduser.displayName!, creduser.email!,
          creduser.phoneNumber, UserType.customer);

      _addUser(user!);
      isAuth = true;

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> addTransaction(TransactionModel data) async {
    return (await db.collection("transactions").add(data.toFirestore())).id;
  }

  static Future<void> updateTransactions() async {
    await db.collection("transactions").where("");
  }
}
