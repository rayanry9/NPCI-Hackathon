import 'package:flutter/material.dart';

class HomeBalance extends StatefulWidget {
  const HomeBalance({super.key});

  @override
  HomeBalanceState createState() => HomeBalanceState();
}

class HomeBalanceState extends State<HomeBalance> {
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
          "42690",
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
