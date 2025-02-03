import 'package:flutter/material.dart';

class SellerButtonsHomescreen extends StatelessWidget{
  const SellerButtonsHomescreen ({super.key});

  @override
  Widget build(BuildContext context){
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
            "504",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              
              child: Text("Buy Points"),
            ),
            SizedBox(
              width: 16,
            ),
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              child: Text("Show QR"),
            ),
          ],
        )
      ],
    );
  }
}