import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    print(Navigator.of(context).toString());
    return Scaffold(
      body: Text(
        "HomeAAAAAAAAAAAAAAAAA",
        
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
      ),
    );
  }
}
