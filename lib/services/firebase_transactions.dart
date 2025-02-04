import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_sellers.dart';
import 'package:uperks/constants/transaction_type.dart';

class MyFireBaseTransactions with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  static List<TransactionModel> _transactions = [];
  static List<TransactionModel> _requests = [];

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

  Future<bool> updateTransactionsCustomer() async {
    try {
      _transactions = (await _db
              .collection("transactions")
              .where("buyerId", isEqualTo: MyFireBaseAuth().user!.id)
              .where("acceptStatus", isEqualTo: AcceptStatus.accepted.name)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList();

      _transactions.addAll((await _db
              .collection("transactions")
              .where("buyerId", isEqualTo: MyFireBaseAuth().user!.id)
              .where("acceptStatus", isEqualTo: AcceptStatus.declined.name)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList());

      _transactions.addAll((await _db
              .collection("transactions")
              .where("sellerId", isEqualTo: MyFireBaseAuth().user!.id)
              .where("type", isEqualTo: TransactionType.sharePoints.name)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList());

      _transactions.addAll((await _db
              .collection("transactions")
              .where("buyerId", isEqualTo: MyFireBaseAuth().user!.id)
              .where("type", isEqualTo: TransactionType.sharePoints.name)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList());

      _transactions
          .sort((a, b) => b.transactionDate!.compareTo(a.transactionDate!));

      for (var elem in _transactions) {
        if (MyFireBaseSellers()
            .sellers
            .where((val) => val.id == elem.sellerId)
            .isEmpty) {
          await MyFireBaseSellers().updateSellersWithId(elem.sellerId!);
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateTransactionsSeller() async {
    try {
      _transactions = (await _db
              .collection("transactions")
              .where("sellerId", isEqualTo: MyFireBaseAuth().user!.id)
              .where("acceptStatus", isEqualTo: AcceptStatus.accepted.name)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList();

      _transactions.addAll((await _db
              .collection("transactions")
              .where(
                "sellerId",
                isEqualTo: MyFireBaseAuth().user!.id,
              )
              .where("acceptStatus", isEqualTo: AcceptStatus.declined.name)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList());

      _transactions.addAll((await _db
              .collection("transactions")
              .where("type", isEqualTo: "buyPoints")
              .where(
                "buyerId",
                isEqualTo: MyFireBaseAuth().user!.id,
              )
              .where("acceptStatus", isEqualTo: AcceptStatus.accepted.name)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList());

      _transactions
          .sort((a, b) => b.transactionDate!.compareTo(a.transactionDate!));

      for (var elem in _transactions) {
        if (MyFireBaseSellers()
            .sellers
            .where((val) => val.id == elem.buyerId)
            .isEmpty) {
          await MyFireBaseSellers().updateSellersWithId(elem.buyerId!);
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateRequestsCustomer() async {
    try {
      _requests = (await _db
              .collection("transactions")
              .where("buyerId", isEqualTo: MyFireBaseAuth().user!.id)
              .where("acceptStatus",
                  isEqualTo: AcceptStatus.pending.name.toString())
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList();

      _requests
          .sort((a, b) => b.transactionDate!.compareTo(a.transactionDate!));
      for (var elem in _requests) {
        if (MyFireBaseSellers()
            .sellers
            .where((val) => val.id == elem.sellerId)
            .isEmpty) {
          await MyFireBaseSellers().updateSellersWithId(elem.sellerId!);
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateRequestsSeller() async {
    try {
      _requests = (await _db
              .collection("transactions")
              .where("sellerId", isEqualTo: MyFireBaseAuth().user!.id)
              .where("acceptStatus", isEqualTo: AcceptStatus.pending.name)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList();

      _transactions.addAll((await _db
              .collection("transactions")
              .where("type", isEqualTo: "buyPoints")
              .where(
                "buyerId",
                isEqualTo: MyFireBaseAuth().user!.id,
              )
              .where("acceptStatus", isEqualTo: AcceptStatus.pending.name)
              .get())
          .docs
          .map((val) => TransactionModel.fromFirestore(val, null))
          .toList());

      _requests
          .sort((a, b) => b.transactionDate!.compareTo(a.transactionDate!));

      for (var elem in _requests) {
        if (MyFireBaseSellers()
            .sellers
            .where((val) => val.id == elem.buyerId)
            .isEmpty) {
          (await MyFireBaseSellers().updateSellersWithId(elem.buyerId!))
              .toString();
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> sellerRequestStatusChange(
      String requestId, AcceptStatus status) async {
    await _db.collection("transactions").doc(requestId).update({
      "acceptStatus": status.name,
    });

    _requests.removeWhere((val) => val.id == requestId);
    notifyListeners();
    updateTransactionsSeller();
    return true;
  }

  List<TransactionModel> get transactions {
    return _transactions;
  }

  List<TransactionModel> get requests {
    return _requests;
  }
}
