import 'package:flutter/material.dart';
import 'package:uperks/widgets/home_balance.dart';

class HomescreenContainer extends StatelessWidget {
	const HomescreenContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeBalance(),
        ],
      ),
    );
  }
}
