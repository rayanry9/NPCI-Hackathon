import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uperks/services/firebase_stores.dart';

class CurrentOffers extends StatelessWidget {
  const CurrentOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyFireBaseStores>(
      builder: (context, store, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25),
          Text(
            "Current Offers",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black),
          ),
          SizedBox(height: 10.0),
          Column(
              children: store.stores.map((offer) {
            return Container(
              padding: EdgeInsets.all(14.0),
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade400),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer.storeName,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          offer.type.name.characters.toList()[0].toUpperCase() +
                              offer.type.name.substring(
                                1,
                              ),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black54),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          offer.address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${offer.offerPercent.toStringAsFixed(0)}%",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
