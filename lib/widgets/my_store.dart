import 'package:flutter/material.dart';
import 'package:uperks/widgets/balance_chart.dart';

class MyStore extends StatelessWidget{
  const MyStore({super.key});

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My Store",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: const TextSpan(
                text: "Store Name",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: " Cafe",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "105 3rd Road, Richmond, VA, 73494",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            BalanceChart()
          ],
        ),
      );
  }
}
