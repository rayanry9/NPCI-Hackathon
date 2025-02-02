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
  DateTime? transactionDate;

  TransactionModel(this.id, this.buyerId, this.sellerId, this.transactionAmount,
      this.rewardPoints, this.type, this.transactionDate);

  TransactionModel.withoutId(
    this.buyerId,
    this.sellerId,
    this.transactionAmount,
    this.rewardPoints,
    this.type,
  )   : id = "",
        transactionDate = DateTime.now();

  factory TransactionModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return TransactionModel(
      snapshot.id,
      data["buyerId"],
      data["sellerId"],
      double.parse(data["transactionAmount"].toString()),
      int.parse(data["rewardPoints"].toString()),
      data["type"] == TransactionType.gainPoints.name
          ? TransactionType.gainPoints
          : TransactionType.redeemPoints,
      DateTime.fromMillisecondsSinceEpoch(data["date"]),
    );
  }

  factory TransactionModel.makeRandomTransaction() {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0912875346';
    return TransactionModel.withoutId(
      List.generate(
              10, (index) => characters[Random().nextInt(characters.length)])
          .join(),
      List.generate(
              10, (index) => characters[Random().nextInt(characters.length)])
          .join(),
      Random().nextDouble() * 10000,
      Random().nextInt(1000),
      TransactionType.values[Random().nextInt(2)],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (buyerId != null) "buyerId": buyerId,
      if (sellerId != null) "sellerId": sellerId,
      if (transactionAmount != null) "transactionAmount": transactionAmount,
      if (rewardPoints != null) 'rewardPoints': rewardPoints,
      if (type != null) 'type': type!.name,
      'date': transactionDate!.millisecondsSinceEpoch,
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
