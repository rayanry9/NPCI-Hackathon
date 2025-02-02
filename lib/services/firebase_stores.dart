import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uperks/models/store_model.dart';

class MyFireBaseStores with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<StoreModel> _stores = [];

  static MyFireBaseStores? _instance;

  MyFireBaseStores.init();
  factory MyFireBaseStores() {
    _instance ??= MyFireBaseStores.init();
    return _instance!;
  }

  Future<String?> addStore(StoreModel store) async {
    return (await _db.collection("stores").add(store.toFirestore())).id;
  }

  Future<bool> updateStoresWithStoreId(String id) async {
    if (_stores.where((store) => store.storeId == id).isNotEmpty) {
      return true;
    } else {
      final result = (await _db.collection("stores").doc(id).get());
      if (result.exists) {
        _stores.add(StoreModel.fromFirestore(result, null));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> updateStoresWithOwnerId(String id) async {
    if (_stores.where((store) => store.ownerId == id).isNotEmpty) {
      return true;
    } else {
      final result = (await _db
          .collection("stores")
          .where("ownerId", isEqualTo: id)
          .get());
      if (result.docs.isNotEmpty) {
        _stores.addAll(
            result.docs.map((doc) => StoreModel.fromFirestore(doc, null)));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
  }

  List<StoreModel> get stores {
    return _stores;
  }
}
