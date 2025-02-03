import 'package:flutter/material.dart';
import 'package:uperks/constants/transaction_type.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/services/firebase_sellers.dart';
import 'package:uperks/services/firebase_transactions.dart';

class NotificationCardAd extends StatelessWidget{

  final TransactionModel transaction;
  const NotificationCardAd({super.key, required this.transaction});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                transaction.buyerId!,
                style: TextStyle(fontSize: 10, color: Colors.black54),
              ),
              Text(
                "Transaction Value: ",
                  style: TextStyle(color: Colors.black54),
                  textAlign: TextAlign.left,
              ),
              Text(
                  transaction.transactionAmount!.toStringAsFixed(2),
                  style: TextStyle(color: Colors.black54),
              ),
              Text(
                "Reward Points Request: ",
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.left,
              ),
              Text(
                transaction.rewardPoints!.toString(),
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                   MyFireBaseTransactions().sellerRequestStatusChange(transaction.id!, AcceptStatus.accepted);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
                ),
                child: Text("Accept"),
              ),
              SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {
                    MyFireBaseTransactions().sellerRequestStatusChange(transaction.id!, AcceptStatus.declined);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text("Decline"),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

