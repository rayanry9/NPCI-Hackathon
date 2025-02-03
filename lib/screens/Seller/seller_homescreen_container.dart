import 'package:flutter/material.dart';
import 'package:uperks/widgets/current_offers.dart';
import 'package:uperks/widgets/home_balance.dart';

class HomescreenContainer extends StatelessWidget {
  const HomescreenContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HomeBalance(),
            CurrentOffers(),
          ],
        ),
      ),
    );
  }
}