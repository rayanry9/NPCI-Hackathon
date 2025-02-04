import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uperks/services/firebase_transactions.dart';
import 'package:uperks/widgets/notification_card_pending.dart';

class NotificationsContainer extends StatelessWidget {
  const NotificationsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
      ),
      body: Consumer<MyFireBaseTransactions>(builder: (context, data, _) {
        return ListView.builder(
          itemCount: data.requests.length,
          itemBuilder: (context, index) {
            return NotificationCardPending(transaction: data.requests[index]);
          },
        );
      }),
    );
  }
}
