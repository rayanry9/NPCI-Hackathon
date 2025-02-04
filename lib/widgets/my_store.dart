import 'package:flutter/material.dart';
import 'package:uperks/models/store_model.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_stores.dart';
import 'package:uperks/widgets/balance_chart.dart';

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "My Store",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                MyFireBaseStores()
                    .stores
                    .getStoreFromOwnerId(MyFireBaseAuth().user!.id)
                    .storeName,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black),
              ),
              Spacer(),
              Text(
                MyFireBaseStores()
                    .stores
                    .getStoreFromOwnerId(MyFireBaseAuth().user!.id)
                    .type
                    .name
                    .replaceRange(
                        0,
                        1,
                        MyFireBaseStores()
                            .stores
                            .getStoreFromOwnerId(MyFireBaseAuth().user!.id)
                            .type
                            .name
                            .characters
                            .toList()[0]
                            .toUpperCase()),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            MyFireBaseStores()
                .stores
                .getStoreFromOwnerId(MyFireBaseAuth().user!.id)
                .address,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Offer Percent: ${MyFireBaseStores().stores.getStoreFromOwnerId(MyFireBaseAuth().user!.id).offerPercent.toStringAsFixed(0)}%",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54),
              ),
              Text(
                "Offer Threshold: ${MyFireBaseStores().stores.getStoreFromOwnerId(MyFireBaseAuth().user!.id).offerThreshold}",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54),
              ),
            ],
          ),
          BalanceChart()
        ],
      ),
    );
  }
}
