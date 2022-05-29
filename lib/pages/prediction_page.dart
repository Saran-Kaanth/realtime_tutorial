import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key}) : super(key: key);

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  // var client = Client();
  Color color = Colors.white;
  // TextEditingController _taskController = TextEditingController();
  late FormController _formController;

  String _textValue = "";

  @override
  void initState() {
    super.initState();

    // _taskController = TextEditingController();
    _formController = FormController();
  }

  // var client = http.Client();
  void main(Map _reqBody) async {
    // var queryParameters = {
    //   'query': query,
    // };

    // var _reqBody = {};
    // _reqBody['pregnancies'] = "0";
    // _reqBody['glucose'] = "0";
    // _reqBody['bp'] = "80";
    // _reqBody['skin_thickness'] = "23";
    // _reqBody['insulin'] = "0";
    // _reqBody['bmi'] = "0";
    // _reqBody['pedi'] = "0.234";
    // _reqBody['age'] = "23";
    // var headers = {'x-api-key': '7VSkbFyyllYBIKwvFsEa5A==U0b9u9ct9A209r0Y'};

    // var url =
    //     Uri.https('api.calorieninjas.com', '/v1/nutrition', queryParameters);
    // Uri.https('10.0.2.2:9600', '/prediction');
    var response = await http.post(Uri.http('10.0.2.2:9600', '/prediction'),
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode(_reqBody));
    // var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      print('$jsonResponse');
      // print(jsonResponse["items"]);
      if (jsonResponse["message"] == "Diabetes") {
        // print("empty");
        // print(jsonResponse["items"]);
        setState(() {
          color = Color.fromARGB(255, 215, 101, 93);
          _textValue = "Good to go! No Diabetes";
        });
      } else {
        setState(() {
          color = Color.fromARGB(255, 77, 225, 69);
          _textValue = "Diabetes! We can take care!";
        });
      }
    } else {
      print('Reponse error with code ${response.statusCode}');
      setState(() {
        color = Color.fromARGB(255, 208, 198, 109);
        _textValue = "Something went wrong! Please try again later";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: color,
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  Container(
                    // color: Colors.grey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // textBaseline: TextBaseline.alphabetic,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 10,
                        ),
                        Text(
                          "Prediction",
                          style: TextStyle(fontSize: 40, fontFamily: "Allison"),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                    child: Center(
                        child: Form(
                      key: _formController.key,
                      child: Column(children: [
                        Column(children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller:
                                _formController.controller("_pregnancy"),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Enter Value";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Pregnancies",
                                helperText: "Number of Pregnancies eg.0",
                                suffixIcon: Icon(Icons.pregnant_woman)),
                          ),
                          SizedBox(
                            height: 6,
                          )
                        ]),
                        Column(children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _formController.controller("_glucose"),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Enter Value";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Glucose(mg/dL)",
                                helperText: "eg.80",
                                suffixIcon: Icon(Icons.bloodtype_outlined)),
                          ),
                          SizedBox(
                            height: 6,
                          )
                        ]),
                        Column(children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _formController.controller("_bp"),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Enter Value";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: "Blood Pressure(mmHg)",
                                  helperText: "eg.80",
                                  suffixIcon: Icon(Icons.bloodtype_outlined))),
                          SizedBox(
                            height: 6,
                          )
                        ]),
                        Column(children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller:
                                _formController.controller("_skinThickness"),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Enter Task";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Skin Thickness(mm)",
                                helperText: "eg.20",
                                suffixIcon:
                                    Icon(Icons.personal_injury_outlined)),
                          ),
                          SizedBox(
                            height: 6,
                          )
                        ]),
                        Column(children: [
                          TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _formController.controller("_bmi"),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Enter Value";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: "BMI(kg/m\u00B2)",
                                  helperText: "eg.24.1",
                                  suffixIcon:
                                      Icon(Icons.personal_injury_outlined))),
                          SizedBox(
                            height: 6,
                          )
                        ]),
                        Column(children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _formController.controller("_insulin"),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Enter Value";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Insulin Level(IU/mL)",
                                helperText: "eg.80",
                                suffixIcon:
                                    Icon(Icons.medication_liquid_outlined)),
                          ),
                          SizedBox(
                            height: 6,
                          )
                        ]),
                        Column(children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _formController.controller("_pedi"),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Enter Value";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Diabetes Pedigree Function",
                                helperText:
                                    "likelihood of Diabetes based on family history eg.0.52",
                                suffixIcon: Icon(Icons.numbers)),
                          ),
                          SizedBox(
                            height: 6,
                          )
                        ]),
                        Column(children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _formController.controller("_age"),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Enter Age";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Age (in years)",
                                helperText: "eg.25",
                                suffixIcon: Icon(Icons.perm_identity_outlined)),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                elevation: 15,
                                color: Colors.white,
                                splashColor: Colors.purpleAccent[700],
                                onPressed: () {
                                  print("button 1");
                                  // print(_formController.controller("name").text.toString());
                                  if (!_formController.key.currentState!
                                      .validate()) {
                                    return;
                                  }
                                  _formController.key.currentState!.save();
                                  var _reqBody = {};
                                  _reqBody['pregnancies'] = double.parse(
                                      _formController
                                          .controller("_pregnancy")
                                          .value
                                          .text);
                                  _reqBody['glucose'] = double.parse(
                                      _formController
                                          .controller("_glucose")
                                          .value
                                          .text);
                                  _reqBody['bp'] = double.parse(_formController
                                      .controller("_bp")
                                      .value
                                      .text);
                                  _reqBody['skin_thickness'] = double.parse(
                                      _formController
                                          .controller("_skinThickness")
                                          .value
                                          .text);
                                  _reqBody['insulin'] = double.parse(
                                      _formController
                                          .controller("_bmi")
                                          .value
                                          .text);
                                  _reqBody['bmi'] = double.parse(_formController
                                      .controller("_insulin")
                                      .value
                                      .text);
                                  _reqBody['pedi'] = double.parse(
                                      _formController
                                          .controller("_pedi")
                                          .value
                                          .text);
                                  _reqBody['age'] = double.parse(_formController
                                      .controller("_age")
                                      .value
                                      .text);
                                  setState(() {
                                    color = Colors.white;
                                  });
                                  print(_reqBody);
                                  print("starting");
                                  main(_reqBody);
                                  if (_textValue == "Good to go! No Diabetes") {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        _textValue,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text(_textValue,
                                          style:
                                              TextStyle(color: Colors.white)),
                                      action: SnackBarAction(
                                        label: 'Links',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }

                                  // MedicalId["emergency_2"] = int.parse(
                                  //     _formController.controller("ec_2").value.text);

                                  // print("error");
                                },
                                child: Text("Predict"),
                                // child: Container(child: Text("Add"), color: Colors.green),
                              ),
                            ])
                      ]),
                    )),
                  ))
                ],
              )),
            )));
  }
}


// IconButton(
          //     onPressed: () {
          //       // color = Colors.green;
          //       setState(() {
          //         color = Colors.white;
          //       });
          //       main("idly");
          //     },
          //     icon: Icon(Icons.search))