import 'package:flutter/material.dart';

class PaymentDialog extends StatelessWidget {
  const PaymentDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.pink,
    );
  }
}
