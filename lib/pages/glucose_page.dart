import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:form_controller/form_controller.dart';
import 'package:intl/intl.dart';
import 'package:realtime_tutorial/pages/food_page.dart';

class GlucosePage extends StatefulWidget {
  const GlucosePage({Key? key}) : super(key: key);

  @override
  State<GlucosePage> createState() => _GlucosePageState();
}

class _GlucosePageState extends State<GlucosePage> {
  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  String _month = "";
  final TextEditingController _textController = TextEditingController();
  late DatabaseReference _ref;
  FirebaseAuth _instance = FirebaseAuth.instance;
  DateFormat dateFormat_1 = DateFormat("yyyy-MM-dd");
  DateFormat dateFormat_2 = DateFormat(" hh:mm:ss");
  FormController _formController = FormController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _month = months[DateTime.now().month - 2].toUpperCase();

    _ref = FirebaseDatabase.instance.ref("users");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        color: Colors.white,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " Home",
              style: TextStyle(fontSize: 40),
            ),
            // SizedBox(
            //   height: 60,
            //   width: 10,
            // ),
            //
            Image.asset(
              'assets/logo.png',
              width: 100,
              height: 100,
              // color: Colors.white.withOpacity(0.8),
              // colorBlendMode: BlendMode.src,
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(
          //   width: 5,
          // ),
          Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         colors: [Colors.blue, Colors.purple, Colors.red])),
            width: 300,
            child: Form(
              key: _formController.key,
              child: TextFormField(
                controller: _formController.controller("glucose"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter Data";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Glucose(mg/dL)",
                  helperText: "eg.87.5",
                ),
              ),
            ),
          ),
          // SizedBox(
          //   width: 5,
          // ),
          Column(
            children: [
              SizedBox(
                height: 4,
              ),
              RaisedButton(
                  onPressed: () {
                    if (!_formController.key.currentState!.validate()) {
                      return;
                    }
                    _formController.key.currentState!.save();
                    print(_instance.currentUser!.uid);

                    double _glucose = double.parse(
                        _formController.controller("glucose").text);
                    _ref
                        .child(_instance.currentUser!.uid)
                        .child("all_data")
                        .child(months[(DateTime.now().month) - 1])
                        .child((DateTime.now().day - 2).toString())
                        // .child("31")
                        .child("glucoseData")
                        // .child(dateFormat_2.format(DateTime.now()))
                        .set(_glucose)
                        .then((value) {
                      print("hii");
                    });
                  },
                  color: Colors.white,
                  elevation: 10,
                  child: Icon(Icons.bloodtype_outlined)),
              Container(
                width: 400,
                height: 60,
                color: Colors.green,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyForm()));
                  },
                  elevation: 10,
                  color: Colors.amber[500],
                  splashColor: Color.fromARGB(255, 84, 177, 87),
                  child: Text(
                    "Calorie Counter",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ]));
  }
}
