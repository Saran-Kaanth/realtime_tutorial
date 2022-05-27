import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:form_controller/form_controller.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:realtime_tutorial/pages/analytics_page.dart';
import 'package:realtime_tutorial/pages/food_page.dart';
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
  final TextEditingController _textController = TextEditingController();
  late DatabaseReference _ref;
  FirebaseAuth _instance = FirebaseAuth.instance;
  DateFormat dateFormat_1 = DateFormat("yyyy-MM-dd");
  DateFormat dateFormat_2 = DateFormat(" hh:mm:ss");
  FormController _formController = FormController();
  List fullDataList = [];
  Map _avgData = {};
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.ref("users");
    _ref
        .child(_instance.currentUser!.uid)
        .child("all_data")
        .child("avg")
        .child(months[(DateTime.now().month) - 1])
        .once()
        .then((value) {
      print("hii");
      if (value.snapshot.value != null) {
        print(value.snapshot.value);

        _avgData = value.snapshot.value as Map;
        print("hii");
        print(_avgData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            color: Colors.grey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SizedBox(
              //   width: 5,
              // ),
              Container(
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
                            .child((DateTime.now().day).toString())
                            .child("glucoseData")
                            // .child(dateFormat_2.format(DateTime.now()))
                            .set(_glucose)
                            .then((value) {
                          double _avgGlucose =
                              (_avgData["avgGlucose"] + _glucose);
                          _ref
                              .child(_instance.currentUser!.uid)
                              .child("all_data")
                              .child("avg")
                              .child(months[(DateTime.now().month) - 1])
                              .set({
                            "avgCarbs": _avgData["avgCarbs"],
                            "avgGlucose": _avgGlucose / 2,
                            "avgFat": _avgData["avgFat"],
                            "avgProtein": _avgData["avgProtein"],
                            "avgCholes": _avgData["avgCholes"],
                            "avgCalories": _avgData["avgCalories"]
                          }).then((value) => print("Glucose success"));
                        });
                      },
                      color: Colors.white,
                      elevation: 10,
                      child: Icon(Icons.bloodtype_outlined))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 400,
            height: 60,
            color: Colors.green,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyForm()));
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
      )),
    ));
  }
}
