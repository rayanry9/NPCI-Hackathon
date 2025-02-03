import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uperks/constants/transaction_type.dart';

class TransactionModel {
  String? id;
  final double? transactionAmount;
  final int? rewardPoints;
  final String? sellerId;
  final String? buyerId;
  final String? storeId;
  final TransactionType? type;
  AcceptStatus acceptStatus;
  DateTime? transactionDate;

  TransactionModel(
      this.id,
      this.buyerId,
      this.sellerId,
      this.storeId,
      this.transactionAmount,
      this.rewardPoints,
      this.type,
      this.acceptStatus,
      this.transactionDate);

  TransactionModel.withoutId(this.buyerId, this.sellerId, this.storeId,
      this.transactionAmount, this.rewardPoints, this.type, this.acceptStatus)
      : id = "",
        transactionDate = DateTime.now();

  factory TransactionModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return TransactionModel(
      snapshot.id,
      data["buyerId"],
      data["sellerId"],
      data["storeId"],
      double.parse(data["transactionAmount"].toString()),
      int.parse(data["rewardPoints"].toString()),
      switch (TransactionType.values
          .indexWhere((tran) => tran.name.contains(data["type"]))) {
        0 => TransactionType.gainPoints,
        1 => TransactionType.redeemPoints,
        2 => TransactionType.sharePoints,
        3 => TransactionType.buyPoints,
        _ => TransactionType.sharePoints
      },
      switch (AcceptStatus.values.indexWhere(
          (stat) => stat.name.contains(data["acceptStatus"].toString()))) {
        0 => AcceptStatus.accepted,
        1 => AcceptStatus.declined,
        2 => AcceptStatus.pending,
        _ => AcceptStatus.pending
      },
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
      List.generate(
              10, (index) => characters[Random().nextInt(characters.length)])
          .join(),
      Random().nextDouble() * 10000,
      Random().nextInt(1000),
      TransactionType.values[Random().nextInt(2)],
      AcceptStatus.pending,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (buyerId != null) "buyerId": buyerId,
      if (sellerId != null) "sellerId": sellerId,
      if (storeId != null) "storeId": storeId,
      if (transactionAmount != null) "transactionAmount": transactionAmount,
      if (rewardPoints != null) 'rewardPoints': rewardPoints,
      if (type != null) 'type': type!.name,
      'date': transactionDate!.millisecondsSinceEpoch,
      'acceptStatus': acceptStatus.name,
    };
  }
}

extension Calculations on List<TransactionModel> {
  int get totalRewardPointsBalance {
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

  TransactionModel findTransactionFromId(String id) {
    return firstWhere((trans) => trans.id == id);
  }
}
