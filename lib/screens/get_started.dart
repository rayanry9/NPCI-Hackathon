import 'package:flutter/material.dart';
import 'package:uperks/screens/home.dart';
import 'package:uperks/screens/register.dart';
import 'package:uperks/widgets/starter_panel.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});
  @override
  Widget build(BuildContext context) {
    return StarterPanel(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Earn the Reward Points you rightfully deserve",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              "Earn and Spend Reward Points on your day-to-day transactions and BIGG purchases. There's no one in this entire world who will be able to stop you from saving big now!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //Navigator.of(context).pushNamed('/');
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
            );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 20),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Text('Get Started'),
            ),
            SizedBox(height: 10),
            Text('Already have an Account? Login',
                style: Theme.of(context).textTheme.bodySmall),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Are you a seller? SignUp here',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
