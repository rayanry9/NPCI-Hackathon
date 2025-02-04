import 'package:flutter/material.dart';
import 'package:uperks/constants/user_type.dart';
import 'package:uperks/services/firebase_auth.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final UserType userType;
  const SignInWithGoogleButton({super.key, required this.userType});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          try {
            MyFireBaseAuth.signInWithGoogle(userType).then((val) {
              if (val == SignInStatus.wrongSignIn) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text("Wrong Way of Signing In! User Already Exists."),
                    ),
                  );
                }
              } else {
                if (userType == UserType.customer) {
                  if (val == SignInStatus.error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error Signing In"),
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/home", (route) => false);
                    }
                  }
                } else {
                  if (val == SignInStatus.sellerDataNotFound) {
                    if (context.mounted) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/signUp", (route) => false);
                    }
                  } else if (val == SignInStatus.ok) {
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/home_seller", (route) => false);
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
