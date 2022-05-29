import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:realtime_tutorial/pages/home_page.dart';
import 'package:intl/intl.dart';
import 'package:realtime_tutorial/pages/medical_edit.dart';

class MedicalIDCard extends StatefulWidget {
  const MedicalIDCard({Key? key}) : super(key: key);
  @override
  State<MedicalIDCard> createState() => _MedicalIDCardState();
}

class _MedicalIDCardState extends State<MedicalIDCard> {
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  var medicalData;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String _name = "";
  String _dob = "";
  String _medCon = "";
  String _medication = "";
  String _bloodType = "";
  String _rhType = "";
  // late int _em_1;
  int _em1 = 0;
  int _em2 = 0;
  var _height;
  var _weight;
  void initState() {
    // TODO: implement initState
    super.initState();
    print(uid);
    final ref = FirebaseDatabase.instance
        .ref("users")
        .child(uid)
        .child("MedicalId")
        .once()
        .then((value) {
      medicalData = value.snapshot.value as Map;
      setState(() {
        _name = medicalData["name"];
        DateTime date = dateFormat.parse(medicalData["dob"]);
        _dob = "${date.day}-${date.month}-${date.year}";
        _em1 = medicalData["emergency_1"];
        _em2 = medicalData["emergency_2"];
        _height = medicalData["height"];
        _weight = medicalData["weight"];
        _bloodType = medicalData["blood_type"];
        _rhType = medicalData["rh_type"];
        _medCon = medicalData["medical_conditions"];
        _medication = medicalData["medication"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Medical ID Card"),
        ),
        body: Center(
          /** Card Widget **/

          child: Card(
            elevation: 90,
            shadowColor: Colors.green[900],
            // color: Colors.black54,
            child: SizedBox(
              width: 400,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green[900],
                      radius: 43,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(FirebaseAuth
                            .instance.currentUser!.photoURL
                            .toString()), //NetworkImage
                        radius: 40,
                      ), //CircleAvatar
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Name",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 30,

                                // color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ),
                            Text(_name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  // fontSize: 30,
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Emergency 1",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 30,

                                // color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ),
                            Text("$_em1",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  // fontSize: 30,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                        // FloatingActionButton(
                        //   elevation: 50,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.zero),
                        //   onPressed: () {
                        //     Navigator.pop(context);
                        //   },
                        //   child: Row(
                        //     children: [Icon(Icons.edit), Text("Edit")],
                        //   ),
                        // ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Row(
                        //     children: [
                        //       Icon(
                        //         Icons.edit,
                        //         color: Colors.white,
                        //       ),
                        //       SizedBox(
                        //         width: 3,
                        //       ),
                        //       Text(
                        //         "Edit",
                        //         style: TextStyle(color: Colors.),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicalEdit()));
                          },
                          // color: Colors.black,
                          elevation: 50,
                          highlightElevation: 23.8,

                          // highlightColor: Colors.white,
                          splashColor: Colors.green[900],
                          child: Row(children: [
                            Icon(
                              Icons.edit,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(color: Colors.green[900]),
                            )
                          ]),
                        ),
                        Column(
                          children: [
                            Text(
                              "Date of Birth",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 30,

                                // color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ),
                            Text(_dob,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  // fontSize: 30,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Emergency 1",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 30,

                                // color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ),
                            Text("$_em2",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  // fontSize: 30,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ), //SizedBox
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Height",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 30,

                                // color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ),
                            Text("$_height cm",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  // fontSize: 30,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Weight",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 30,

                                // color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ),
                            Text("$_weight kg",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  // fontSize: 30,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Blood Tyoe",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 30,

                                // color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ),
                            Text("$_bloodType $_rhType",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  // fontSize: 30,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Medical Conditions",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 30,

                                // color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ),
                            Text("$_medCon",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  // fontSize: 30,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Medications (Medicines)",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 30,

                                // color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ),
                            Text("$_medication",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  // fontSize: 30,
                                  color: Colors.green[900],
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        )
                      ],
                    )
                  ],
                ), //Column
              ), //Padding
            ), //SizedBox
          ),
        ) //Card
        );
  }
}
