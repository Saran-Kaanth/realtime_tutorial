import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realtime_tutorial/pages/home_page.dart';
import 'package:realtime_tutorial/pages/login_page.dart';

class SocialAuthService {
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const LoginPage();
          }
        });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print("hii");

    print(FirebaseAuth.instance.signInWithCredential(credential));

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
