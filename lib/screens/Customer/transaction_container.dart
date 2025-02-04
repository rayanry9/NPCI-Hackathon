import 'package:flutter/material.dart';
import 'package:uperks/constants/transaction_type.dart';
import 'package:uperks/models/transaction_model.dart';
import 'package:uperks/models/user_model.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_sellers.dart';
import 'package:uperks/services/firebase_transactions.dart';

class TransactionContainer extends StatefulWidget {
  const TransactionContainer({super.key});

  @override
  TransactionContainerState createState() => TransactionContainerState();
}

class TransactionContainerState extends State<TransactionContainer> {
  List<TransactionModel> data = [];
  List<TransactionModel> filteredData = [];
  String searchQuery = "";

  @override
  void initState() {
    data = MyFireBaseTransactions().transactions;
    filteredData = List.from(data);
    super.initState();
  }

  Color getColor(AcceptStatus status,TransactionType type){
    switch(status){
      case AcceptStatus.accepted:
        switch(type){
          case TransactionType.gainPoints:
          return Colors.lightGreen;
          case TransactionType.redeemPoints:
          return Theme.of(context).primaryColor;
          case TransactionType.sharePoints:
            return Colors.blue;
          case _: return Colors.black;
        }
      case AcceptStatus.declined:
        return Colors.red;
      case _:
      return Colors.black;
    }
  }

  void _filterTransactions(String filterType) {
    setState(() {
      if (filterType == 'clear') {
        filteredData = List.from(data);
      } else if (filterType == 'redeemed') {
        filteredData =
            data.where((t) => t.type == TransactionType.redeemPoints).toList();
      } else if (filterType == 'earned') {
        filteredData =
            data.where((t) => t.type == TransactionType.gainPoints).toList();
      } else if (filterType == 'shared') {
        filteredData =
            data.where((t) => t.type == TransactionType.sharePoints).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
                filteredData = data
                    .where((transaction) => MyFireBaseSellers()
                        .sellers
                        .getNameFromId(transaction.sellerId!)
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .toList();
              });
            },
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Search by seller...',
              suffixIcon: IconButton(
                icon: Icon(Icons.tune),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text("Clear"),
                              onTap: () {
                                _filterTransactions('clear');
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text("Redeemed"),
                              onTap: () {
                                _filterTransactions('redeemed');
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text("Earned"),
                              onTap: () {
                                _filterTransactions('earned');
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text("Shared"),
                              onTap: () {
                                _filterTransactions('shared');
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: filteredData.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final transaction = filteredData[index];

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 42),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyFireBaseSellers()
                            .sellers
                            .getNameFromId(transaction.sellerId!),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        transaction.transactionDate!
                            .toString()
                            .substring(0, 10),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        transaction.rewardPoints.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: getColor(transaction.acceptStatus, transaction.type!)),
                      ),
                      Text(
                        transaction.acceptStatus == AcceptStatus.accepted
                            ? switch (transaction.type!) {
                                TransactionType.sharePoints =>
                                  transaction.sellerId! ==
                                          MyFireBaseAuth().user!.id
                                      ? "Shared Given"
                                      : "Shared Taken",
                                TransactionType.gainPoints => "Earned",
                                TransactionType.redeemPoints => "Redeemed",
                                _ => "Others"
                              }
                            : "Declined",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
