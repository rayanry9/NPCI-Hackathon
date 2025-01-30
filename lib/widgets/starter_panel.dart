import 'package:flutter/material.dart';

class StarterPanel extends StatelessWidget {
  final Widget child;

  const StarterPanel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: IntrinsicHeight(
        child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: child),
      ),
    );
  }
}
