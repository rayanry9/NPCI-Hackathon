import 'package:flutter/material.dart';
import 'package:uperks/widgets/starter_panel.dart';

class Register extends StatelessWidget{
  const Register({super.key});
  @override
  Widget build(BuildContext context){
    return StarterPanel(
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
          ],
        ),
     );
  }
}