import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uperks/constants/theme.dart';
import 'package:uperks/firebase_options.dart';
import 'package:uperks/screens/get_started.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          child: GetStarted(),
        ),
      ),
    );
  }
}
