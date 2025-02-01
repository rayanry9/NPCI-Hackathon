import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uperks/constants/store_type.dart';

class StoreModel {
  final String storeId;
  final String ownerId;
  final String address;
  final String storeName;
  final String offerValue;
  final StoreType type;

  StoreModel.withoutId(
      this.ownerId, this.address, this.storeName, this.offerValue, this.type)
      : storeId = "";

  StoreModel(this.storeId, this.ownerId, this.address, this.storeName,
      this.offerValue, this.type);

  factory StoreModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return StoreModel(
      snapshot.id,
      data["ownerId"],
      data["address"],
      data["storeName"],
      data["offerValue"],
      switch (data["type"]) {
        _ => StoreType.unknown,
      },
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "ownerId": ownerId,
      "address": address,
      "storeName": storeName,
      'offerValue': offerValue,
      'type': type.name,
    };
  }
}
