import 'package:flutter/material.dart';
import 'package:uperks/constants/theme.dart';
import 'package:uperks/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPerks',
      theme: lightTheme,
      home: const AuthStart(),
    );
  }
}

class AuthStart extends StatelessWidget{
  const AuthStart({super.key});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                /*image: DecorationImage(
                  image: 
                  fit: BoxFit.cover,
                )
                */
              )
            )
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Earn the Reward Points you rightfully deserve",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text("Earn and Spend Reward Points on your day-to-day transactions and BIGG purchases. There's no one in this entire world who will be able to stop you from saving big now!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white)
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text('Get Started'),
                  ),

                  SizedBox(height: 10),
                  TextButton(
                    onPressed: (){},
                    child: Text('Already have an Account? Login', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: (){},
                    child: Text('Are you a seller? Login or SignUp here'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

