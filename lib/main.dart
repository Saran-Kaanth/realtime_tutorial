import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:realtime_tutorial/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realtime_tutorial/pages/main_page.dart';
import 'package:realtime_tutorial/screens/home_screen.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}
