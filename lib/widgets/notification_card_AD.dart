import 'package:flutter/material.dart';
import 'package:uperks/constants/transaction_type.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/services/firebase_sellers.dart';
import 'package:uperks/services/firebase_transactions.dart';

class NotificationCardAD extends StatelessWidget{

	final TransactionModel transaction;

	const NotificationCardAD({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //Widget.name,
                    transaction.buyerId!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Transaction Value: ",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        "4200",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Reward Points Request: ",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        "420",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                 
                    SizedBox(height: 8),
                    Text(
                      "Status: ${transaction.acceptStatus.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:transaction.acceptStatus == AcceptStatus.accepted ? Colors.green : Colors.red,
                      ),
                    ),
                 
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    MyFireBaseTransactions().sellerRequestStatusChange(transaction.id!, AcceptStatus.accepted);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Accept"),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    MyFireBaseTransactions().sellerRequestStatusChange(transaction.id!, AcceptStatus.declined);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Decline"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


