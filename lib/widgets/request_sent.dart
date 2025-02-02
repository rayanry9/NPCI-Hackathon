import 'package:flutter/material.dart';
import 'package:uperks/models/transaction_model.dart';

class RequestSent extends StatelessWidget {
  final TransactionModel transaction;
  const RequestSent({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_rounded),
              SizedBox(height: 20),
              Text(
                '${transaction.rewardPoints}',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.black),
              ),
              Text(
                'Reward Points',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.orange),
              ),
              Text(
                'Request Sent',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black),
              ),
              SizedBox(height: 70),
              Text(
                'Store {Store Name}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
              ),
              Text(
                'Transaction Value ${transaction.transactionAmount}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
              ),
              Text(
                'Transaction Id: ${transaction.id}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
