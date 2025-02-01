import 'package:flutter/material.dart';
import 'package:uperks/models/transaction_model.dart';

class HomeBalance extends StatefulWidget {
  const HomeBalance({super.key});

  @override
  HomeBalanceState createState() => HomeBalanceState();
}

class HomeBalanceState extends State<HomeBalance> {
  List<TransactionModel> data = [];

  @override
  void initState() {
    for (int i = 0; i < 30; i++) {
      data.add(TransactionModel.makeRandomTransaction());
    }
    super.initState();
  }

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
          data.rewardPoints.toString(),
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
                onPressed: () {},
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
                onPressed: () {},
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
