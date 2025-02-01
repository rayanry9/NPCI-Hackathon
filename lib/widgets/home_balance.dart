import 'package:flutter/material.dart';
import 'package:uperks/constants/transaction_type.dart';
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
            ElevatedButton(onPressed: () {}, child: Text("Scan")),
            OutlinedButton(onPressed: () {}, child: Text("Redeem"))
          ],
        ),
      ],
    );
  }
}
