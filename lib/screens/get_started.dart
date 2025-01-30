import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget{
	const GetStarted({super.key});
	@override
	Widget build(BuildContext context) {
    return Container(
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(2), 
				color:Color.from(alpha: 1, red: 255, green: 255, blue: 255), 
			),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                /*image: DecorationImage(
                  image: 
                  fit: BoxFit.cover,
                )
                */
              )
            )
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Earn the Reward Points you rightfully deserve",
                    textAlign: TextAlign.center,
										style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 10),
                  Text("Earn and Spend Reward Points on your day-to-day transactions and BIGG purchases. There's no one in this entire world who will be able to stop you from saving big now!",
                    textAlign: TextAlign.center,
										style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text('Get Started'),
                  ),

                  SizedBox(height: 10),
                  TextButton(
                    onPressed: (){},
                    child: Text('Already have an Account? Login', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: (){},
                    child: Text('Are you a seller? Login or SignUp here'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
	}
}
