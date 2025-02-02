import 'package:flutter/material.dart';

class CurrentOffers extends StatelessWidget {
  CurrentOffers({super.key});

  final List<Map<String, String>> offers = [
    {
      "name": "Cafe Coffee Day",
      "category": "Cafe",
      "address": "845 Ssi Hill Highway, Duke Energy Bldg, Austin, Texas, 52483",
      "discount": "5%",
    },
    {
      "name": "FUCK ME Day",
      "category": "Cafe",
      "address":
          "3474 NW Rockwood Loop, Kearns Building, Oklahoma City, OK, 75766",
      "discount": "8%",
    },
    {
      "name": "Nescafe Day",
      "category": "Cafe",
      "address": "2616 N Mount Street, Jefferson City, Missouri, 89997",
      "discount": "2%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
            children: offers.map((offer) {
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
                        offer["name"]!,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        offer["category"]!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black54),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        offer["address"]!,
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
                    offer["discount"]!,
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
    );
  }
}
