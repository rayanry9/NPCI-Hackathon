import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uperks/constants/transaction_type.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/services/firebase_sellers.dart';
import 'package:uperks/services/firebase_stores.dart';
import 'package:uperks/services/firebase_transactions.dart';
import 'package:uperks/widgets/payment_dialog.dart';
import 'package:uperks/widgets/scanner.dart';

class HomeBalance extends StatelessWidget {
  const HomeBalance({super.key});

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
              .totalRewardPointsBalanceCustomer
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
                onPressed: () async {
                  final qrValue = (await Scanner.scanQrCode(context));
                  if (context.mounted) {
                    if (qrValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid Scan"),
                        ),
                      );
                    } else {
                      if (await MyFireBaseSellers()
                          .updateSellersWithId(qrValue)) {
                        if (context.mounted) {
                          await MyFireBaseStores()
                              .updateStoreWithOwnerId(qrValue);
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) => PaymentDialog(
                                transactionType: TransactionType.gainPoints,
                                sellerId: qrValue,
                              ),
                            );
                          }
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid Scan"),
                            ),
                          );
                        }
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Scan"),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  final qrValue = (await Scanner.scanQrCode(context));
                  if (context.mounted) {
                    if (qrValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid Scan"),
                        ),
                      );
                    } else {
                      if (await MyFireBaseSellers()
                          .updateSellersWithId(qrValue)) {
                        if (context.mounted) {
                          await MyFireBaseStores()
                              .updateStoreWithOwnerId(qrValue);
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) => PaymentDialog(
                                transactionType: TransactionType.redeemPoints,
                                sellerId: qrValue,
                              ),
                            );
                          }
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid Scan"),
                            ),
                          );
                        }
                      }
                    }
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Redeem"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
