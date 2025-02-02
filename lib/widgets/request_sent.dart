import 'package:flutter/material.dart';

class RequestSent extends StatelessWidget {
  const RequestSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_rounded),
              SizedBox(height: 20),
              Text(
                'Request Sent',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
