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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        'assets/logo.png',
                        width: 250,
                        height: 250,
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
                                        image: AssetImage('assets/google.png'),
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
