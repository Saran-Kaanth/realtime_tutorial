import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:form_controller/form_controller.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:realtime_tutorial/pages/analytics_page.dart';
import 'package:realtime_tutorial/pages/medical_id.dart';
import 'package:realtime_tutorial/pages/prediction_page.dart';
import 'package:realtime_tutorial/pages/profile_page.dart';
import 'package:realtime_tutorial/schemas/medical_schema.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Column(children: [
      Container(
        color: Colors.grey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          // textBaseline: TextBaseline.alphabetic,
          children: [
            SizedBox(
              height: 60,
              width: 10,
            ),
            Text(
              "GluDiaSys",
              style: TextStyle(fontSize: 40, fontFamily: "Allison"),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 350,
      ),
      Center(
          child: Text(
        "Home Page",
        style: TextStyle(fontSize: 40),
      ))
    ]))));
  }
}
