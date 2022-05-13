import 'dart:ffi';

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
  // final _formkey = GlobalKey<FormState>();
  late DatabaseReference _ref;
  // TextEditingController _taskController = TextEditingController();
  late FormController _formController;

  String uid = "anu";
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  var MedicalId = {};
  var dob;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.ref("users");

    // _taskController = TextEditingController();
    _formController = FormController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GluDiaSys"),
        centerTitle: true,
        backgroundColor: Colors.purple[900],
        actions: [
          IconButton(
              onPressed: () {
                print("logout");
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              key: _formController.key,
              child: Column(children: [
                Column(children: [
                  TextFormField(
                    controller: _formController.controller("name"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Task";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Enter Name",
                        suffixIcon: Icon(Icons.perm_identity)),
                  ),
                  SizedBox(
                    height: 6,
                  )
                ]),
                Column(children: [
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      // border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'DOB',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    // validator: (e) =>
                    //     (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      String _dob = dateFormat.format(value);
                      dob = _dob;
                    },
                  ),
                  SizedBox(
                    height: 6,
                  )
                ]),
                Column(children: [
                  TextFormField(
                    controller: _formController.controller("med_con"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Task";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Medical Conditions",
                        suffixIcon: Icon(Icons.emergency)),
                  ),
                  SizedBox(
                    height: 6,
                  )
                ]),
                Column(children: [
                  TextFormField(
                      controller: _formController.controller("medication"),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Task";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Medications(Medicines)",
                        suffixIcon: Icon(Icons.medication),
                      )),
                  SizedBox(
                    height: 6,
                  )
                ]),
                Column(children: [
                  TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _formController.controller("height"),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Task";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Height",
                        suffixIcon: Icon(Icons.height),
                      )),
                  SizedBox(
                    height: 6,
                  )
                ]),
                Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _formController.controller("weight"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Task";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Weight", suffixIcon: Icon(Icons.scale)),
                  ),
                  SizedBox(
                    height: 6,
                  )
                ]),
                Column(children: [
                  TextFormField(
                    controller: _formController.controller("blood_type"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Task";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Blood Type",
                        suffixIcon: Icon(Icons.bloodtype)),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ]),
                Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _formController.controller("ec_1"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Task";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Emergency Contact 1",
                        suffixIcon: Icon(Icons.numbers)),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ]),
                Column(children: [
                  TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _formController.controller("ec_2"),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Task";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Emergency Contact 2",
                        suffixIcon: Icon(Icons.numbers),
                      )),
                  SizedBox(
                    height: 6,
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      elevation: 15,
                      color: Colors.grey[300],
                      splashColor: Colors.purpleAccent[700],
                      onPressed: () {
                        print("button 1");
                        // print(_formController.controller("name").text.toString());
                        if (!_formController.key.currentState!.validate()) {
                          return;
                        }
                        _formController.key.currentState!.save();
                        MedicalId["name"] =
                            _formController.controller("name").text.toString();
                        // print(MedicalId["dob"]);
                        MedicalId["dob"] = dob.toString();
                        // print(MedicalId["name"]);
                        MedicalId["medical_conditions"] = _formController
                            .controller("med_con")
                            .text
                            .toString();
                        // print(MedicalId["name"]);
                        MedicalId["medication"] = _formController
                            .controller("medication")
                            .text
                            .toString();
                        // print(MedicalId["name"]);
                        MedicalId["height"] = double.parse(
                            _formController.controller("height").text);
                        ;
                        // print(MedicalId["name"]);
                        MedicalId["weight"] = double.parse(
                            _formController.controller("weight").text);

                        // print(MedicalId["name"]);
                        MedicalId["blood_type"] = _formController
                            .controller("blood_type")
                            .text
                            .toString();
                        // print(MedicalId["emergency_1"]);
                        MedicalId["emergency_1"] =
                            int.parse(_formController.controller("ec_1").text);
                        // print(MedicalId["name"]);
                        MedicalId["emergency_2"] = int.parse(
                            _formController.controller("ec_2").value.text);

                        uid = MedicalId["name"];
                        _ref
                            .child(uid)
                            .child("MedicalId")
                            .set(MedicalId)
                            .then((value) =>
                                // ignore: avoid_print
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MedicalIDCard(
                                              uid: uid,
                                            ))));
                        print(MedicalId);

                        // print("error");
                      },
                      child: Text("Add"),
                      // child: Container(child: Text("Add"), color: Colors.green),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      elevation: 15,
                      color: Colors.grey[300],
                      splashColor: Colors.red,
                      onPressed: () {
                        print("button 1");
                        _formController.controller("name").clear();
                        _formController.controller("dob").clear();
                        _formController.controller("med_con").clear();
                        _formController.controller("medication").clear();
                        _formController.controller("height").clear();
                        _formController.controller("weight").clear();
                        _formController.controller("ec_1").clear();
                        _formController.controller("ec_2").clear();
                        _formController.controller("blood_type").clear();
                      },
                      child: Text("Clear"),
                      // child: Container(child: Text("Add"), color: Colors.green),
                    )
                    // child: Container(color: LinearGradient(colors:[Color.fromARGB(255, 145, 81, 81),Color.fromARGB(255, 52, 146, 55),Color.fromARGB(255, 77, 135, 181)]),))
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 80,
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: pageIndex,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.analytics), label: "Analytics"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.lens_blur_sharp), label: "Prediction"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle_outlined), label: "Profile")
      //   ],
      //   onTap: (int index) {
      //     print(index);
      //     pages[index];
      //   },
      // ),
    );
  }
}
