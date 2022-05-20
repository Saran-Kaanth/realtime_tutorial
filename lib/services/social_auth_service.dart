import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:realtime_tutorial/pages/login_page.dart';
import 'package:realtime_tutorial/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return MainPage();
        } else {
          return LoginPage();
        }
      },
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

// signInWithGoogle() async{
//   FirebaseAuth _auth=FirebaseAuth.instance();

//   GoogleSignInAccount googleSignInAccount=await _go
// }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<dynamic> signup(BuildContext context) async {
    User _user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: GoogleSignInAuthentication.idToken,
          accessToken: GoogleSignInAuthentication.accessToken);

      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      bool state = result.additionalUserInfo!.isNewUser;
      print(state);
      if (result != null) {
        if (state) {
          DateFormat dateFormat = DateFormat("yyyy-MM-dd");
          DatabaseReference _ref;
          _ref = FirebaseDatabase.instance.ref("users");

          _ref.child(user!.uid).child("login_data").set({
            "date_created": dateFormat.format(DateTime.now()),
            "display_name": user.displayName,
            "user_email": user.email,
            "user_mobile": user.phoneNumber,
            "verified": user.emailVerified,
          });

          print("hii");
          return 0;
          // Navigator.pushReplacement(
          //   context, MaterialPageRoute(builder: (context) => MainPage()));
        }
        print("bye");
        return 0;
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    }
  }
}
