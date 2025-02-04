import 'package:flutter/material.dart';
import 'package:uperks/constants/transaction_type.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/models/user_model.dart';
import 'package:uperks/services/firebase_sellers.dart';
import 'package:uperks/services/firebase_transactions.dart';

class NotificationCardAd extends StatelessWidget {
  final TransactionModel transaction;
  const NotificationCardAd({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Column(
        spacing: 12,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                MyFireBaseSellers().sellers.getNameFromId(transaction.buyerId!),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black),
              ),
              Row(
                spacing: 12,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (MyFireBaseTransactions()
                                  .transactions
                                  .totalRewardPointsBalanceSeller -
                              transaction.rewardPoints! >=
                          0) {
                        MyFireBaseTransactions().sellerRequestStatusChange(
                            transaction.id!, AcceptStatus.accepted);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Not Enough Balance to give Redeem Points")));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      minimumSize: Size.zero,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text("Accept",
                        style: Theme.of(context).textTheme.bodyMedium!),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      MyFireBaseTransactions().sellerRequestStatusChange(
                          transaction.id!, AcceptStatus.declined);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size.zero,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Decline",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 8,
                children: [
                  Text(
                    "Transaction Value",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    transaction.transactionAmount!.toStringAsFixed(2),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                spacing: 8,
                children: [
                  Text(
                    "Reward Points Request: ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    transaction.rewardPoints!.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
