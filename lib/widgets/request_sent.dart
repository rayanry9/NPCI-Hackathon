import 'package:flutter/material.dart';
import 'package:uperks/models/store_model.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/services/firebase_stores.dart';

class RequestSent extends StatelessWidget {
  final TransactionModel transaction;
  const RequestSent({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        Icon(Icons.check_circle_rounded,
                            size: 80, color: Colors.green),
                        SizedBox(height: 20),
                        Text(
                          '${transaction.rewardPoints}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Reward Points',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.orange),
                        ),
                        Text(
                          'Request Sent',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'Store ${MyFireBaseStores().stores.getStoreFromStoreId(transaction.storeId!)}',
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
                        SizedBox(height: 40),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
