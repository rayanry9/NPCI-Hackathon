import 'package:flutter/material.dart';
import 'package:uperks/constants/theme.dart';
import 'package:uperks/screens/get_started.dart';
import 'package:uperks/screens/home.dart';
import 'package:uperks/widgets/starter_panel.dart';

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
      home: const Scaffold(
        body: Center(
          child: StarterPanel(text: "UPerks goated asf bruhhhh"),
        ),
      ),
    );
  }
}


