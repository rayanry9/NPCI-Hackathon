import 'package:flutter/material.dart';
import 'package:uperks/constants/transaction_type.dart';
import 'package:uperks/models/store_model.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_stores.dart';
import 'package:uperks/services/firebase_transactions.dart';

class RequestSent extends StatelessWidget {
  final TransactionModel transaction;
  const RequestSent({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    if (transaction.sellerId == MyFireBaseAuth().user!.id) {
      MyFireBaseTransactions().updateRequestsSeller();
    } else {
      MyFireBaseTransactions().updateRequestsCustomer();
    }
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_rounded, size: 80, color: Colors.green),
							transaction.type == TransactionType.gainPoints?
              Text(
                '${transaction.rewardPoints}',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.black),
              ):
              Text(
                '${transaction.rewardPoints!/MyFireBaseAuth.customerRedeemRate!}',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.black),
              ),
							transaction.type == TransactionType.gainPoints?
              Text(
                'Reward Points',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.orange),
              ):
              Text(
                'Redeemed Amount',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.orange),
              )
							,
              Text(
                'Request Sent',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
              Text(
                'Store ${MyFireBaseStores().stores.getStoreFromStoreId(transaction.storeId!).storeName}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54),
              ),
              Text(
                'Transaction Value: ${transaction.transactionAmount}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54),
              ),
              Text(
                'Transaction Date: ${transaction.transactionDate}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54),
              ),
              Text(
                'Transaction Id: ${transaction.id}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
