// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:realtime_tutorial/pages/main_page.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final GoogleSignIn googleSignIn = new GoogleSignIn();
//   late String result;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     result = "";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Login"),
//         ),
//         body: Material(
//             color: Colors.transparent,
//             child: InkWell(
//                 borderRadius: new BorderRadius.circular(8.0),
//                 onTap: () async {
//                   _handleSignIn();
//                 },
//                 child: Padding(
//                     padding: EdgeInsets.only(top: 12, bottom: 12),
//                     child: Center(
//                         child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text('Continue with Google',
//                               textAlign: TextAlign.center),
//                         ]))))));
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       GoogleSignInAccount? data = await googleSignIn.signIn() ?? null;

//       print(data.toString());
//       if (data != null) {
//         print(data.displayName);
//         print(data.email);
//         print(data.id);
//         print(data.photoUrl);

//         setState(() {
//           result = data.displayName! + ' - ' + data.id;
//         });
//       }
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => MainPage()));
//     } catch (error) {
//       print(error);
//     }
//   }
// }

import 'package:realtime_tutorial/pages/login_page.dart';
import 'package:realtime_tutorial/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realtime_tutorial/services/social_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue, Colors.red])),
            child: Card(
                margin:
                    EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
                elevation: 20,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "GluDiaSys",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: MaterialButton(
                            color: Colors.teal[100],
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/googleimage.png'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Sign In with Google")
                              ],
                            ),
                            onPressed: () {
                              AuthService().signup(context);
                            },
                          )),
                    ]))));
  }
}

// final FirebaseAuth auth = FirebaseAuth.instance;

// Future<void> signup(BuildContext context) async {
//   User _user;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//   if (googleSignInAccount != null) {
//     final GoogleSignInAuthentication = await googleSignInAccount.authentication;
//     final AuthCredential authCredential = GoogleAuthProvider.credential(
//         idToken: GoogleSignInAuthentication.idToken,
//         accessToken: GoogleSignInAuthentication.accessToken);

//     UserCredential result = await auth.signInWithCredential(authCredential);
//     User? user = result.user;
//     bool state = result.additionalUserInfo!.isNewUser;
//     print(state);
//     if (result != null) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => MainPage()));
//     }
//   }

