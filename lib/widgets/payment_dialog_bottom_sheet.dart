import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uperks/models/transaction_model.dart';
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
            Spacer(),
            Text(
              _sliderCurrentValue.floor().toString(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black),
            ),
            Slider(
              min: 1,
              max: min(
                  MyFireBaseTransactions()
                      .transactions
                      .totalRewardPointsBalanceCustomer
                      .toDouble(),
                  widget.transactionValue),
              divisions: min(
                          MyFireBaseTransactions()
                              .transactions
                              .totalRewardPointsBalanceCustomer
                              .toDouble(),
                          widget.transactionValue)
                      .floor() -
                  1,
              value: _sliderCurrentValue.toDouble(),
              onChanged: (val) {
                setState(() {
                  _sliderCurrentValue = val.floor();
                });
              },
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_sliderCurrentValue);
                },
                child: Text("Complete Transaction")),
          ],
        ),
      ),
    );
  }
}
