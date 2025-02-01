import 'dart:math';

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

  factory TransactionModel.makeRandomTransaction() {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0912875346';
    return TransactionModel.withoutId(
        List.generate(
                10,
                (index) =>
                    characters[Random(12371983).nextInt(characters.length)])
            .toString(),
        List.generate(
                10,
                (index) =>
                    characters[Random(89257035).nextInt(characters.length)])
            .toString(),
        Random(45678972).nextDouble() * 10000,
        Random(1230998).nextInt(1000),
        TransactionType.values[Random(98980083).nextInt(1)]);
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

extension Calculations on List<TransactionModel> {
  int get rewardPoints {
    return where(
            (tranasctionModel) =>
                tranasctionModel.type == TransactionType.gainPoints).fold<int>(
            0,
            (prevValue, transaction) => prevValue + transaction.rewardPoints!) -
        where((tranasctionModel) =>
                tranasctionModel.type == TransactionType.redeemPoints)
            .fold<int>(
                0,
                (prevValue, transaction) =>
                    prevValue + transaction.rewardPoints!);
  }
}
