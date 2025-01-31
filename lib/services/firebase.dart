import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uperks/constants/user_type.dart';

class MyFireBaseAuth {
	static bool isAuth=false;
	static UserCredential? userCredential;

  static Future<bool> signInWithGoogle() async {
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
      userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
			isAuth = true;
			MyFireBaseFireStoreDB.db.collection("users").doc(getUID()!).set({
				'name': getName(),
				'email': getEmail(),
				'userType': UserType.customer.name.toString(),
				'phoneNumber': 0000000000,
			});

      return true;
    } catch (e) {
      return false;
    }
  }

	static String? getName(){
		if(userCredential == null){
			return null;
		}
		return userCredential!.user!.displayName;
	}	
	static String? getEmail(){
		if(userCredential == null){
			return null;
		}
		return userCredential!.user!.email;
	}
	static String? getUID(){
		if(userCredential == null){
			return null;
		}
		return userCredential!.user!.uid;
	}
}

class MyFireBaseFireStoreDB{
	static final db = FirebaseFirestore.instance;
}
