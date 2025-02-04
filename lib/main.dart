import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uperks/constants/theme.dart';
import 'package:uperks/constants/user_type.dart';
import 'package:uperks/firebase_options.dart';
import 'package:uperks/screens/Customer/notifications_container.dart';
import 'package:uperks/screens/Seller/home_seller.dart';
import 'package:uperks/screens/Seller/notifications_seller.dart';
import 'package:uperks/screens/Seller/signup_form.dart';
import 'package:uperks/screens/get_started.dart';
import 'package:uperks/screens/Customer/home.dart';
import 'package:uperks/screens/register.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_sellers.dart';
import 'package:uperks/services/firebase_stores.dart';
import 'package:uperks/services/firebase_transactions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MyFireBaseSellers().updateSellersWithId("admin");
  await MyFireBaseAuth.getRates();
  final bool userDataFilled = await MyFireBaseAuth().updateUser();
  if (MyFireBaseAuth.isAuth) {
    if (MyFireBaseAuth().user!.userType == UserType.seller) {
      await MyFireBaseStores()
          .updateStoreWithOwnerId(MyFireBaseAuth().user!.id);
      await MyFireBaseTransactions().updateTransactionsSeller();
      await MyFireBaseTransactions().updateRequestsSeller();
    } else {
      await MyFireBaseTransactions().updateTransactionsCustomer();
      await MyFireBaseTransactions().updateRequestsCustomer();
    }
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyFireBaseTransactions()),
        ChangeNotifierProvider(create: (context) => MyFireBaseStores()),
        ChangeNotifierProvider(create: (context) => MyFireBaseSellers()),
        ChangeNotifierProvider(create: (context) => MyFireBaseAuth()),
      ],
      child: MyApp(
        userDataFilled: userDataFilled,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool userDataFilled;
  const MyApp({super.key, required this.userDataFilled});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPerks',
      theme: getLightTheme(context),
      initialRoute: MyFireBaseAuth.isAuth == true
          ? (MyFireBaseAuth().user!.userType == UserType.customer
              ? '/home'
              : (userDataFilled ? '/home_seller' : '/signUp'))
          : '/get_started',
      routes: {
        '/home': (context) => Home(),
        '/get_started': (context) => GetStarted(),
        '/register': (context) => Register(),
        '/signUp': (context) => SignUpForm(),
        '/home_seller': (context) => HomeSeller(),
        '/notifications_seller': (context) => NotificationsSeller(),
        '/notifications_customer': (context) => NotificationsContainer(),
      },
    );
  }
}
