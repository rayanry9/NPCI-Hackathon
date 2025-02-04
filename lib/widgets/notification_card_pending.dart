import 'package:flutter/material.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/models/user_model.dart';
import 'package:uperks/services/firebase_sellers.dart';

class NotificationCardPending extends StatelessWidget {
  final TransactionModel transaction;
  const NotificationCardPending({super.key, required this.transaction});

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
                MyFireBaseSellers()
                    .sellers
                    .getNameFromId(transaction.sellerId!),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black),
              ),
              Row(
                spacing: 12,
                children: [
                  Text(
                    "Pending",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  )
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
