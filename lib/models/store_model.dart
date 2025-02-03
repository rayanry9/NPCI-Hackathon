import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uperks/constants/store_type.dart';

class StoreModel {
  final String storeId;
  final String ownerId;
  final String address;
  final String storeName;
  final double offerPercent;
  final double offerThreshold;
  final StoreType type;
  final String storeUpiID;

  StoreModel.withoutId(
    this.ownerId,
    this.address,
    this.storeName,
    this.offerPercent,
    this.offerThreshold,
    this.storeUpiID,
    this.type,
  ) : storeId = "";

  StoreModel(this.storeId, this.ownerId, this.address, this.storeName,
      this.offerPercent, this.offerThreshold, this.storeUpiID, this.type);

  factory StoreModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return StoreModel(
      snapshot.id,
      data["ownerId"],
      data["address"],
      data["storeName"],
      data["offerPercent"],
      data["offerThreshold"],
      data["storeUpiID"],
      StoreType.values.firstWhere((type) => type.name == data["type"],
          orElse: () => StoreType.others),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "ownerId": ownerId,
      "address": address,
      "storeName": storeName,
      'offerPercent': offerPercent,
      'offerThreshold': offerThreshold,
      'storeUpiID': storeUpiID,
      'type': type.name,
    };
  }
}

extension Calculations on List<StoreModel> {
  String getNameFromStoreId(String id) {
    return where((store) => store.storeId == id).first.storeName;
  }

  List<String> getNamesFromOwnerId(String id) {
    return where((store) => store.ownerId == id)
        .map((store) => store.storeName)
        .toList();
  }
}
