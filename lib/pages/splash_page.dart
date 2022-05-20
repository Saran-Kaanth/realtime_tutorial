import 'package:flutter/material.dart';
import 'package:realtime_tutorial/services/social_auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AuthService().handleAuth()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              color: Colors.blueGrey,
              child: Material(
                color: Colors.blueGrey,
                animationDuration: kThemeAnimationDuration,
                child: Text(
                  "Welcome",
                  style: TextStyle(fontSize: 25),
                ),
              ))),
    );
  }
}
