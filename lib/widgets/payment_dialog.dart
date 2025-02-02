import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For TextInputFormatter
import 'package:uperks/constants/payment_type.dart';
import 'package:uperks/models/user_model.dart';
import 'package:uperks/services/firebase.dart';
import 'package:uperks/widgets/request_sent.dart';

class PaymentDialog extends StatefulWidget {
  final PaymentType type;
  final String id;

  const PaymentDialog({super.key, required this.type, required this.id});

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
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
              "Requesting ${MyFireBase.instance.sellers.getNameFromId(widget.id)}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black),
            ),
            Text(
              "Store {Store Name}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey),
            ),
            SizedBox(height: 10),
            // TextField for user input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                // Restrict input to 2 decimal places
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: '0',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.black,
              )
            ),
            SizedBox(height: 10),
            Text(
              _amountController.text.isEmpty
                  ? '\$0.00'
                  : '\$${_amountController.text}',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.black),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle the input and proceed
            final enteredAmount = _amountController.text;
            if (enteredAmount.isNotEmpty) {
              print('Entered amount: \$${enteredAmount}');
            }
            Navigator.of(context).pop();
            showDialog(context: context, builder: (context) => RequestSent());
          },
          child: Icon(Icons.arrow_forward_ios, color: Colors.black),

        ),
      ),
    );
  }
}
