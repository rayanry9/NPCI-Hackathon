import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uperks/models/user_model.dart';

class MyFireBaseSellers with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<UserModel> _sellers = [];
  static MyFireBaseSellers? _instance;

  MyFireBaseSellers._init();
  factory MyFireBaseSellers() {
    _instance ??= MyFireBaseSellers._init();
    return _instance!;
  }

  Future<bool> updateSellersWithId(String id) async {
    if (_sellers.where((seller) => seller.id == id).isNotEmpty) {
      return true;
    } else {
      try {
        final result = await _db.collection("users").doc(id).get();
        if (result.exists) {
          _sellers.add(UserModel.fromFirestore(result, null));
          notifyListeners();
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    }
  }

  List<UserModel> get sellers {
    return _sellers;
  }
}
