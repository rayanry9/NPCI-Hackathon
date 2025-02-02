import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/models/user_model.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_sellers.dart';

class MyFireBaseTransactions with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  List<TransactionModel> _transactions = [];

  static MyFireBaseTransactions? _instance;

  factory MyFireBaseTransactions() {
    if (_instance == null) {
      _instance = MyFireBaseTransactions.init();
      return _instance!;
    } else {
      return _instance!;
    }
  }
  MyFireBaseTransactions.init();

  Future<String?> addTransaction(TransactionModel data) async {
    return (await _db.collection("transactions").add(data.toFirestore())).id;
  }

  Future<bool> updateTransactions() async {
    try {
      _transactions = (await _db
              .collection("transactions")
              .where("buyerId", isEqualTo: MyFireBaseAuth().user!.id)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList();

      for (var elem in _transactions) {
        if (MyFireBaseSellers()
            .sellers
            .where((val) => val.id == elem.sellerId)
            .isEmpty) {
          final result =
              (await _db.collection("users").doc(elem.sellerId).get());

          if (result.exists) {
            MyFireBaseSellers()
                .sellers
                .add(UserModel.fromFirestore(result, null));
          }
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
}
