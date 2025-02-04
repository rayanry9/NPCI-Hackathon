import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/services/firebase_transactions.dart';

class SellerHomeBalance extends StatelessWidget {
  const SellerHomeBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Available Balance",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black54),
        ),
        Text(
          Provider.of<MyFireBaseTransactions>(context)
              .transactions
              .totalRewardPointsBalanceSeller
              .toString(),
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Buy Points"),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: OutlinedButton(
                onPressed: () async {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Change Offer"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
