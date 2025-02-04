import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_transactions.dart';

class PaymentDialogBottomSheet extends StatefulWidget {
  final String sellerId;
  final double transactionValue;
  const PaymentDialogBottomSheet(
      {super.key, required this.sellerId, required this.transactionValue});

  @override
  State<StatefulWidget> createState() => PaymentDialogBottomSheetState();
}

class PaymentDialogBottomSheetState extends State<PaymentDialogBottomSheet> {
  int _sliderCurrentValue = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Redeem your Points",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.black),
            ),
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  spacing: 4,
                  children: [
                    Text(
                      "Reward Points Using",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black54),
                    ),
                    Text(
                      _sliderCurrentValue.floor().toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
                Column(
                  spacing: 4,
                  children: [
                    Text(
                      "Redeem Amount",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black54),
                    ),
                    Text(
                      (_sliderCurrentValue / MyFireBaseAuth.customerRedeemRate!)
                          .floor()
                          .toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            Slider(
              min: 1,
              max: min(
                  (MyFireBaseTransactions()
                              .transactions
                              .totalRewardPointsBalanceCustomer -
                          MyFireBaseTransactions().requests.totalPendingRedeems)
                      .toDouble(),
                  widget.transactionValue * MyFireBaseAuth.customerRedeemRate!),
              divisions: (min(
                          (MyFireBaseTransactions()
                                      .transactions
                                      .totalRewardPointsBalanceCustomer -
                                  MyFireBaseTransactions()
                                      .requests
                                      .totalPendingRedeems)
                              .toDouble(),
                          widget.transactionValue *
                              MyFireBaseAuth.customerRedeemRate!) /
                      MyFireBaseAuth.customerRedeemRate!)
                  .floor(),
              value: _sliderCurrentValue.toDouble(),
              onChanged: (val) {
                setState(() {
                  _sliderCurrentValue = val.floor();
                });
              },
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(_sliderCurrentValue);
              },
              child: Text("Complete Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
