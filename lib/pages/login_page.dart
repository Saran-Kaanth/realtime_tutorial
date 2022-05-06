import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realtime_tutorial/services/social_auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "GluDiaSys",
                style: TextStyle(fontSize: 25.0, color: Colors.deepPurple),
              ),
              ElevatedButton(
                  onPressed: () {
                    UserCredential result =
                        SocialAuthService().signInWithGoogle();
                  },
                  child: Text("Login with Google"))
            ],
          ),
        ));
  }
}
