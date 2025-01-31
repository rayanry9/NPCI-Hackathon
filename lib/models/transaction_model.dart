import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uperks/constants/transaction_type.dart';

class TransactionModel {
  final String? id;
  final double? transactionAmount;
  final int? rewardPoints;
  final String? sellerId;
  final String? buyerId;
  final TransactionType? type;

  const TransactionModel(
    this.id,
    this.buyerId,
    this.sellerId,
    this.transactionAmount,
    this.rewardPoints,
    this.type,
  );

  const TransactionModel.withoutId(
    this.buyerId,
    this.sellerId,
    this.transactionAmount,
    this.rewardPoints,
    this.type,
  ) : id = "";

  factory TransactionModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return TransactionModel(
        snapshot.id,
        data["buyerId"],
        data["sellerId"],
        data["transactionAmount"],
        data["rewardPoints"],
        data["type"] == TransactionType.gainPoints.name
            ? TransactionType.gainPoints
            : TransactionType.redeemPoints);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (buyerId != null) "buyerId": buyerId,
      if (sellerId != null) "sellerId": sellerId,
      if (transactionAmount != null) "transactionAmount": transactionAmount,
      if (rewardPoints != null) 'rewardPoints': rewardPoints,
      if (type != null) 'type': type!.name,
    };
  }
}
