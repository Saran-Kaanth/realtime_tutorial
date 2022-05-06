import 'package:flutter/material.dart';
import 'package:realtime_tutorial/services/social_auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SocialAuthService().handleAuth()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GluDiaSys"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                SocialAuthService().signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
