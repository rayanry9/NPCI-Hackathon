import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uperks/screens/Seller/seller_homescreen_container.dart';
import 'package:uperks/screens/Seller/seller_profile_container.dart';
import 'package:uperks/screens/Seller/seller_transaction_container.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_transactions.dart';

enum NavigationTabs { home, transactions, profile }

class HomeSeller extends StatefulWidget {
  const HomeSeller({super.key});

  @override
  HomeSellerState createState() => HomeSellerState();
}

class HomeSellerState extends State<HomeSeller> {
  NavigationTabs selectedIndex = NavigationTabs.home;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String greeting() {
    int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Good Morning, ";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon, ";
    } else {
      return "Good Evening, ";
    }
  }

  Future<void> refreshScreen() async {
    print('refresh ho gaya, gol gol ghumne waali cheez aa gayi');
    await MyFireBaseTransactions().updateRequestsSeller();
    await MyFireBaseTransactions().updateTransactionsSeller();
  }

  Widget _getSelectedContainer() {
    switch (selectedIndex) {
      case NavigationTabs.home:
        return SellerHomescreenContainer();
      case NavigationTabs.transactions:
        return SellerTransactionContainer();
      case NavigationTabs.profile:
        return SellerProfileContainer();
    }
  }

  @override
  void initState() {
    MyFireBaseTransactions().updateTransactionsSeller();
    MyFireBaseTransactions().updateRequestsSeller();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        title: Consumer<MyFireBaseAuth>(
          builder: (context, data, _) => Text(
            greeting() + ((data.user == null) ? "" : data.user!.name),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        scrolledUnderElevation: 0,
        actions: [
          Consumer<MyFireBaseTransactions>(builder: (context, data, _) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(
                    data.requests.isEmpty
                        ? Icons.notifications
                        : Icons.notification_important,
                    color: Colors.blue),
                onPressed: () {
                  MyFireBaseTransactions().updateRequestsSeller();
                  Navigator.of(context).pushNamed("/notifications_seller");
                },
              ),
            );
          }),
        ],
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refreshScreen,
        child: ListView(
          children: [_getSelectedContainer()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex.index,
        onTap: (index) {
          setState(() {
            selectedIndex = NavigationTabs.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
      ),
    );
  }
}
