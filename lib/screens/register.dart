import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uperks/widgets/starter_panel.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ["email"]).signIn();

    try {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: StarterPanel(
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
              ElevatedButton(
                onPressed: () {
                  signInWithGoogle().then((val) {
                    if (val) {
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/home", (route) => false);
                      }
                    }else{
                      SnackBar(content: Text("Error Signin In"));
                    }
                  });
                },
                child: Text("Sign In With Google"))
            ],
          ),
        ));
  }
}
