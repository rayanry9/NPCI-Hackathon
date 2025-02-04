import 'package:flutter/material.dart';
import 'package:uperks/constants/user_type.dart';
import 'package:uperks/widgets/sign_in_with_google_btn.dart';
import 'package:uperks/widgets/starter_panel.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final fromType = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StarterPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "The Influence of Deliberate Parameter",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              "Regardless of the fact that the matter of the profit should focus on The Approach of Intelligent Evaluation (Mauro Aquino in The Book of the Increasing Growth of Technology and Productivity)",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 40),
            SignInWithGoogleButton(
              userType: fromType!.toString().toLowerCase().contains("seller")
                  ? UserType.seller
                  : UserType.customer,
            ),
          ],
        ),
      ),
    );
  }
}
