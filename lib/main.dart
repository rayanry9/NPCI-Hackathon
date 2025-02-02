import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uperks/constants/theme.dart';
import 'package:uperks/firebase_options.dart';
import 'package:uperks/screens/get_started.dart';
import 'package:uperks/screens/home.dart';
import 'package:uperks/screens/register.dart';
import 'package:uperks/services/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MyFireBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPerks',
      theme: getLightTheme(context),
      initialRoute: MyFireBase.instance.isAuth ? '/home' : '/get_started',
      routes: {
        '/home': (context) => ChangeNotifierProvider(
              create: (context) => MyFireBase(),
              child: Home(),
            ),
        '/get_started': (context) => GetStarted(),
        '/register': (context) => Register(),
      },
    );
  }
}
