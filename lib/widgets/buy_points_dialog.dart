import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For TextInputFormatter
import 'package:uperks/constants/transaction_type.dart';
import 'package:uperks/models/store_model.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/models/user_model.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_sellers.dart';
import 'package:uperks/services/firebase_stores.dart';
import 'package:uperks/services/firebase_transactions.dart';
import 'package:uperks/widgets/request_sent.dart';

class PaymentDialog extends StatelessWidget {
  final String sellerId;
  final TransactionType transactionType;
  PaymentDialog(
      {super.key, required this.transactionType, required this.sellerId});

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            SizedBox(height: 10),
            Text(
              "Requesting ${MyFireBaseSellers().sellers.getNameFromId(sellerId)}",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
            ),
            Text(
              "Store ${MyFireBaseStores().stores.getStoreFromOwnerId(sellerId).storeName}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black54),
            ),
            SizedBox(height: 10),
            // TextField for user input
            IntrinsicWidth(
              child: TextField(
                controller: TextEditingController(),
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                autofocus: true,
                textAlign: TextAlign.center,
                inputFormatters: [
                  // Restrict input to 2 decimal places
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  prefixText: '\$',
                  border: InputBorder.none,
                  hintText: '0',
                  constraints: BoxConstraints(),
                ),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.black),
              ),
            ),
            Text(
              "Transaction Value",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black45),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Handle the input and proceed
            final enteredAmount = double.tryParse(_amountController.text);
            if (enteredAmount != 0 &&
                _amountController.text != "" &&
                enteredAmount != null) {
              final transact = TransactionModel.withoutId(
                  MyFireBaseAuth().user!.id,
                  sellerId,
                  MyFireBaseStores()
                      .stores
                      .getStoreFromOwnerId(sellerId)
                      .storeId,
                  enteredAmount,
                  enteredAmount >
                          MyFireBaseStores()
                              .stores
                              .getStoreFromOwnerId(sellerId)
                              .offerThreshold
                      ? (enteredAmount *
                              MyFireBaseStores()
                                  .stores
                                  .getStoreFromOwnerId(sellerId)
                                  .offerPercent /
                              100)
                          .floor()
                      : 0,
                  transactionType,
                  AcceptStatus.pending);

              // TODO : add check if failed
              final id =
                  (await MyFireBaseTransactions().addTransaction(transact));
              transact.id = id;
              if (context.mounted) {
                Navigator.of(context).pop();

                showDialog(
                    context: context,
                    builder: (context) => RequestSent(transaction: transact));
              }
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Value cannot be 0")));
            }
          },
          child: Icon(Icons.arrow_forward_ios, color: Colors.black),
        ),
      ),
    );
  }
}
