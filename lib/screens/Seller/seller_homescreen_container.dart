import 'package:flutter/material.dart';
import 'package:uperks/widgets/my_store.dart';
import 'package:uperks/widgets/seller_buttons_homescreen.dart';

class SellerHomescreenContainer extends StatelessWidget {
  const SellerHomescreenContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SellerButtonsHomescreen(),
            //MyStore(),
          ],
        ),
      ),
    );
  }
}
