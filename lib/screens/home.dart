import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  const Home({super.key});
  
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<Home>{
  int selectedIndex = 0;

  String greeting() {
    int hour = DateTime.now().hour;
    if(hour>=5 && hour<12) return "Good Morning";
    else if(hour>=12 && hour<17) return "Good Afternoon";
    else return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title:  Text(
          greeting(),
          style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.notifications, color: Colors.blue),
            onPressed: (){
              print("notifications ko dabaya");
            },
          ),
        ),
      ],
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
    ),

    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
      onTap: (index){
        setState((){
          selectedIndex = index;
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
