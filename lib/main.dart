import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uperks/constants/theme.dart';
import 'package:uperks/firebase_options.dart';
import 'package:uperks/screens/Customer/get_started.dart';
import 'package:uperks/screens/Customer/home.dart';
import 'package:uperks/screens/Customer/register.dart';
import 'package:uperks/screens/Seller/signup_form.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_transactions.dart';

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
      theme: getLightTheme(context),
      initialRoute: MyFireBaseAuth.isAuth == true ? '/home' : '/get_started',
      routes: {
        '/home': (context) {
          MyFireBaseAuth().updateUser().then((val) {
            if (val) {
              MyFireBaseTransactions().updateTransactions();
            }
          });
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => MyFireBaseAuth()),
              ChangeNotifierProvider(
                create: (context) => MyFireBaseTransactions(),
              ),
            ],
            child: Home(),
          );
        },
        '/get_started': (context) => GetStarted(),
        '/register': (context) => Register(),
      },
    );
  }
}
