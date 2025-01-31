import 'package:flutter/material.dart';
import 'package:uperks/services/firebase.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        MyFireBase.signInWithGoogle().then((val) {
          if (val) {
            if (context.mounted) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/home", (route) => false);
            }
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Error Signin In")));
            }
          }
        });
      },
      child: Text("Sign In With Google"),
    );
  }
}
