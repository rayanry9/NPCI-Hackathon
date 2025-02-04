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
import 'package:uperks/widgets/payment_dialog_bottom_sheet.dart';
import 'package:uperks/widgets/request_sent.dart';

class PaymentDialog extends StatefulWidget {
  final String sellerId;
  final TransactionType transactionType;
  const PaymentDialog(
      {super.key, required this.transactionType, required this.sellerId});

  @override
  State<StatefulWidget> createState() => PaymentDialogState();
}

class PaymentDialogState extends State<PaymentDialog> {
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
              "Requesting ${MyFireBaseSellers().sellers.getNameFromId(widget.sellerId)}",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
            ),
            Text(
              "Store ${MyFireBaseStores().stores.getStoreFromOwnerId(widget.sellerId).storeName}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black54),
            ),
            SizedBox(height: 10),
            // TextField for user input
            IntrinsicWidth(
              child: TextField(
                controller: _amountController,
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
              switch (widget.transactionType) {
                case TransactionType.gainPoints:
                  final transact = TransactionModel.withoutId(
                      MyFireBaseAuth().user!.id,
                      widget.sellerId,
                      MyFireBaseStores()
                          .stores
                          .getStoreFromOwnerId(widget.sellerId)
                          .storeId,
                      enteredAmount,
                      enteredAmount >
                              MyFireBaseStores()
                                  .stores
                                  .getStoreFromOwnerId(widget.sellerId)
                                  .offerThreshold
                          ? (enteredAmount *
                                  MyFireBaseStores()
                                      .stores
                                      .getStoreFromOwnerId(widget.sellerId)
                                      .offerPercent /
                                  100)
                              .floor()
                          : 0,
                      widget.transactionType,
                      AcceptStatus.pending);

                  final id =
                      (await MyFireBaseTransactions().addTransaction(transact));

                  transact.id = id;
                  if (context.mounted) {
                    Navigator.of(context).pop();

                    showDialog(
                        context: context,
                        builder: (context) =>
                            RequestSent(transaction: transact));
                  }

                  break;
                case TransactionType.redeemPoints:
                  final rewardPoints = await showModalBottomSheet(
                      context: context,
                      builder: (context) => PaymentDialogBottomSheet(
                          sellerId: widget.sellerId,
                          transactionValue: enteredAmount));

                  final transact = TransactionModel.withoutId(
                      MyFireBaseAuth().user!.id,
                      widget.sellerId,
                      MyFireBaseStores()
                          .stores
                          .getStoreFromOwnerId(widget.sellerId)
                          .storeId,
                      enteredAmount,
                      rewardPoints,
                      widget.transactionType,
                      AcceptStatus.pending);

                  final id =
                      (await MyFireBaseTransactions().addTransaction(transact));

                  transact.id = id;
                  if (context.mounted) {
                    Navigator.of(context).pop();

                    showDialog(
                        context: context,
                        builder: (context) =>
                            RequestSent(transaction: transact));
                  }

                  break;
                case TransactionType.sharePoints:
                  break;
                case _:
                  break;
              }

              // TODO : add check if failed
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
