import 'package:flutter/material.dart';
import 'package:uperks/constants/payment_type.dart';

class PaymentDialog extends StatelessWidget {
  final PaymentType type;
  final String id;

  const PaymentDialog({super.key, required this.type, required this.id});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.pink,
    );
  }
}
