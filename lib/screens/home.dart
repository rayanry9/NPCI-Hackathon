import 'package:flutter/material.dart';
import 'package:uperks/screens/homescreen_container.dart';
import 'package:uperks/screens/profile_container.dart';
import 'package:uperks/screens/transaction_container.dart';

enum NavigationTabs { home, transactions, profile }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  NavigationTabs selectedIndex = NavigationTabs.home;

  String greeting() {
    int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  Future<void> refreshScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    print('refresh ho gaya, gol gol ghumne waali cheez aa gayi');

    setState(() {
      selectedIndex = NavigationTabs.home;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          greeting(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Colors.blue),
              onPressed: () {
                print("notifications ko dabaya");
              },
            ),
          ),
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: refreshScreen,
        child: switch (selectedIndex) {
          NavigationTabs.home => HomescreenContainer(),
          NavigationTabs.transactions => TransactionContainer(),
          NavigationTabs.profile => ProfileContainer(),
        },
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
