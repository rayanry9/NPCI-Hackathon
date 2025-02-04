import 'package:flutter/material.dart';

class PaymentDialogBottomSheet extends StatelessWidget {
  final String sellerId;
  final double transactionValue;
  const PaymentDialogBottomSheet(
      {super.key, required this.sellerId, required this.transactionValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(300);
              },
              child: Text("Complete Transaction")),
        ],
      ),
    );
  }
}
