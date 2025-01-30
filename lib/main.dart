import 'package:flutter/material.dart';
import 'package:uperks/constants/theme.dart';
import 'package:uperks/screens/get_started.dart';
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
      home: const GetStarted(),
    );
  }
}


