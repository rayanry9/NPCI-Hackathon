import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uperks/models/store_model.dart';

class MyFireBaseStores with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<StoreModel> _stores = [];

  Future<String?> addStore(StoreModel store) async {
    return (await _db.collection("stores").add(store.toFirestore())).id;
  }

  Future<bool> updateStoresWithId(String id) async {
    if (_stores.where((store) => store.storeId == id).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  List<StoreModel> get stores {
    return _stores;
  }
}
