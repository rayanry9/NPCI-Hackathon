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

class TransactionCard extends StatefulWidget {
  final String name;
  final String status;
  final Function(String) onStatusChange;

  TransactionCard({required this.name, required this.status, required this.onStatusChange});

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
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
                    widget.name,
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
                  if (widget.status.isNotEmpty) ...[
                    SizedBox(height: 8),
                    Text(
                      "Status: ${widget.status}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.status == "Accepted" ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.onStatusChange("Accepted");
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
                    widget.onStatusChange("Declined");
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


