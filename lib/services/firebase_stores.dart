import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uperks/models/store_model.dart';

class MyFireBaseStores with ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  List<StoreModel> _stores = [];

  static MyFireBaseStores? _instance;

  MyFireBaseStores.init();
  factory MyFireBaseStores() {
    _instance ??= MyFireBaseStores.init();
    return _instance!;
  }

  Future<String?> addStore(StoreModel store) async {
    return (await _db.collection("stores").add(store.toFirestore())).id;
  }

  Future<bool> updateStoreWithStoreId(String id) async {
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

  Future<bool> updateStoreWithOwnerId(String id) async {
    if (_stores.where((store) => store.ownerId == id).isNotEmpty) {
      return true;
    } else {
      final result = (await _db
          .collection("stores")
          .where("ownerId", isEqualTo: id)
          .get());
      if (result.docs.isNotEmpty) {
        _stores.add(StoreModel.fromFirestore(result.docs.first, null));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
  }

  void getAllStores() {
    _db.collection("stores").get().then((val) {
      _stores =
          val.docs.map((doc) => StoreModel.fromFirestore(doc, null)).toList();
      print(_stores.first);
      notifyListeners();
    });
  }

  List<StoreModel> get stores {
    return _stores;
  }
}
