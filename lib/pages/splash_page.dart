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
      color: Colors.white70,
      // color: Colors.blueGrey,

      child: Image.asset(
        'assets/logo.png',
        width: 250,
        height: 250,
        // color: Colors.white.withOpacity(0.8),
        // colorBlendMode: BlendMode.src,
      ),

      // child: ImageIcon(
      //   AssetImage("assets/logo.png"),
      //   //  color: Colors.red,
      //   size: 24,
      // ),
      // child: Material(
      //   color: Colors.blueGrey,
      //   animationDuration: kThemeAnimationDuration,
      //   child: Text(
      //     "Welcome",
      //     style: TextStyle(fontSize: 25),
      //   ),
      // ))),
    )));
  }
}
