import 'package:flutter/material.dart';
import 'package:uperks/services/firebase_auth.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          try {
            MyFireBaseAuth.signInWithGoogle().then((val) {
              if (val) {
                if (context.mounted) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/home", (route) => false);
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error Signing In"),
                    ),
                  );
                }
              }
            });
          } catch (e) {
            print(e);

            if (context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Error Signing In")));
            }
          }
        },
        icon: Image.asset(
          'assets/google_icon.png',
          height: 24,
          width: 24,
        ),
        label: const Text("Sign In With Google"),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}
