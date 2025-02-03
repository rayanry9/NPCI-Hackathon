import 'package:flutter/material.dart';

class NotificationsSeller extends StatefulWidget {
  @override
  NotificationsSellerState createState() => NotificationsSellerState();
}

class NotificationsSellerState extends State<NotificationsSeller> {
  final List<Map<String, dynamic>> transactions = [
    {"name": "Mana Schneider", "status": ""},
    {"name": "Truman Hartman", "status": ""},
    {"name": "Les Bordelon", "status": ""},
    {"name": "Alishia Tillman", "status": ""},
    {"name": "Les Bordelon", "status": ""},
  ];

  void updateStatus(int index, String newStatus) {
    setState(() {
      transactions[index]["status"] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return TransactionCard(
            name: transactions[index]["name"],
            status: transactions[index]["status"],
            onStatusChange: (String newStatus) {
              updateStatus(index, newStatus);
            },
          );
        },
      ),
    );
  }
}

