import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uperks/constants/user_type.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/models/user_model.dart';

class MyFireBase with ChangeNotifier {
  bool isAuth = (FirebaseAuth.instance.currentUser != null);
  final db = FirebaseFirestore.instance;
  UserModel? user;
  List<TransactionModel> _transactions = [];
  List<UserModel> _sellers = [];

  static MyFireBase instance = MyFireBase.init();

  factory MyFireBase() {
    return instance;
  }

  MyFireBase.init() {
    if (isAuth) {
      db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((val) {
        user = UserModel.fromFirestore(val, null);
        instance.updateTransactions();
      });
    }
  }

  Future<void> _addUser(UserModel user) {
    return db.collection("users").doc(user.id).set(user.toFirestore());
  }

  Future<bool> signInWithGoogle() async {
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

  Future<String?> addTransaction(TransactionModel data) async {
    return (await db.collection("transactions").add(data.toFirestore())).id;
  }

  Future<bool> updateTransactions() async {
    try {
      _transactions = (await db
              .collection("transactions")
              .where("buyerId", isEqualTo: user!.id)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList();
      for (var elem in _transactions) {
        if (_sellers.where((val) => val.id == elem.sellerId).isEmpty) {
          _sellers.add(UserModel.fromFirestore(
              (await db.collection("users").doc(elem.sellerId).get()), null));
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<TransactionModel> get transactions {
    return _transactions;
  }

  List<UserModel> get sellers {
    return _sellers;
  }
}
