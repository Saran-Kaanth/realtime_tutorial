import 'dart:collection';
import 'dart:ffi';

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
// import 'package:line_chart/charts/line-chart.widget.dart';
// import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

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
  Color _fontColor = Colors.white;
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  double _minY = 0.0;
  double _maxY = 5.0;
  double _minX = 0;
  double _maxX = 10;
  List<FlSpot> calories_spots = [FlSpot(0, 1), FlSpot(1, 2), FlSpot(2, 90)];
  List<FlSpot> glucose_spots = [FlSpot(0, 1), FlSpot(1, 2), FlSpot(2, 90)];
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
  var _avgGlucose = "";
  var _avgCalories = "";
  var _avgCholes = "";
  var _avgFat = "";
  var _avgProtein = "";
  var _avgCarbs = "";
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the blue line
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _month = months[DateTime.now().month - 1].toUpperCase();

    _ref = FirebaseDatabase.instance.ref("users");

    _ref
        .child(_instance.currentUser!.uid)
        .child("all_data")
        .child(months[(DateTime.now().month) - 1])
        .once()
        .then((value) {
      print("calories");
      Map all_data = value.snapshot.value as Map;
      print(all_data);
      List fullDataList = [];
      setState(() {
        print(all_data.keys);
        final sortedAllData = SplayTreeMap<String, dynamic>.from(
            all_data, (keys1, keys2) => keys1.compareTo(keys2));
        print(sortedAllData.keys);
        // print(sortedAllData.keys.length);

        List keys = sortedAllData.keys.toList();
        if (keys.length > 8) {
          int count = 1;
          int val = keys.length - 1;
          calories_spots.clear();
          glucose_spots.clear();

          while (count <= 8) {
            var x = double.parse(keys[val]);
            var cal_y = all_data[(keys[val].toString())]["foodData"]
                ["total_nutrients"]["total_cal_g"];
            var glu_y = all_data[(keys[val].toString())]["glucoseData"];
            // var y = all_data[(keys[val].toString())]["foodData"]
            //     ["total_nutrients"]["total_cal_g"];
            if (cal_y.runtimeType == double) {
              calories_spots.add(FlSpot(x, cal_y.ceilToDouble()));
              glucose_spots.add(FlSpot(x, glu_y));
            } else {
              calories_spots.add(FlSpot(x, cal_y.ceilToDouble()));
              glucose_spots.add(FlSpot(x, glu_y));
            }

            count++;
            val--;
          }
        } else {
          int val = keys.length - 1;

          calories_spots.clear();
          glucose_spots.clear();
          while (val >= 0) {
            var x = double.parse(keys[val]);
            var cal_y = all_data[(keys[val].toString())]["foodData"]
                ["total_nutrients"]["total_cal_g"];
            var glu_y = all_data[(keys[val].toString())]["glucoseData"];
            // var y = all_data[(keys[val].toString())]["foodData"]
            //     ["total_nutrients"]["total_cal_g"];
            if (cal_y.runtimeType == double) {
              calories_spots.add(FlSpot(x, cal_y.ceilToDouble()));
              glucose_spots.add(FlSpot(x, glu_y));
            } else {
              calories_spots.add(FlSpot(x, cal_y.ceilToDouble()));
              glucose_spots.add(FlSpot(x, glu_y));
            }

            val--;
          }
        }
      });
    });
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
        // print("hii");
        print(_avgData);
        setState(() {
          _avgCalories = _avgData["avgCalories"].toStringAsFixed(2);
          _avgCarbs = _avgData["avgCarbs"].toStringAsFixed(2);
          _avgFat = _avgData["avgFat"].toStringAsFixed(2);
          _avgProtein = _avgData["avgProtein"].toStringAsFixed(2);
          _avgGlucose = _avgData["avgGlucose"].toStringAsFixed(2);
          _avgCholes = _avgData["avgCholes"].toStringAsFixed(2);
        });
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
          Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
            child: Container(
                width: double.infinity,
                height: 270,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.red[400],
                  color: Colors.blueGrey[300],
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              // color: Colors.red,
                              child: Column(children: [
                                Text("Avg. Carbs. \nLvl.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _fontColor,
                                    )),
                                Text(_avgCarbs + " g",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ))
                              ]),
                            ),
                            Container(
                              // color: Colors.white,
                              child: Column(children: [
                                Text("Avg. Cholesterol\nLvl.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _fontColor,
                                    )),
                                Text(_avgCholes + " mg",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ))
                              ]),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // color: Colors.red,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Avg. Glucose \nLvl.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: _fontColor, fontSize: 25)),
                                    Text(_avgGlucose + " mg/dL",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18))
                                  ]),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              // color: Colors.white,
                              child: Column(children: [
                                Text("Avg. Calories \nLvl.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: _fontColor, fontSize: 25)),
                                Text(_avgCalories + " g",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18))
                              ]),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              // color: Colors.red,
                              child: Column(children: [
                                Text("Avg. Fat Lvl.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _fontColor,
                                    )),
                                Text(_avgFat + " g",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ))
                              ]),
                            ),
                            Container(
                              // color: Colors.white,
                              child: Column(children: [
                                Text("Avg. Protein\nLvl.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _fontColor,
                                    )),
                                Text(_avgProtein + " g",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ))
                              ]),
                            ),
                          ],
                        ),
                      ]),
                )),
          ),
          Card(
            color: Colors.grey[400],
            elevation: 15,
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "$_month month Glucose Range Data for \nLast few Days(in mg/dL)",
                          // "Glucose Increased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.\nI think you have to reduce your glucose level a\nlittle bit! Don't worry Try to add these foods!",

                          // "Glucose Increased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.Try to take\nmore amount of carbohydrates food to increase\nyour glucose level and try to add these foods!",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
              child: Container(
                // width: double.infinity,
                // height: 300,
                width: double.infinity,
                height: 290,
                // padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                child: Card(
                    elevation: 20,
                    shadowColor: Colors.red[400],
                    child: Container(
                        // color: Colors.blueGrey[400],
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 13, 13, 13),
                      child: LineChart(
                        LineChartData(
                            minY: 50,
                            maxY: 150,
                            // minX: _minX,
                            // maxX: _maxX,
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 20,
                                        interval: 1)),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 30,
                                        interval: 20))),
                            lineBarsData: [
                              LineChartBarData(
                                  gradient: LinearGradient(colors: [
                                    Colors.black,
                                    Colors.grey,
                                    Colors.black
                                  ]),
                                  shadow: Shadow(color: Colors.yellow),
                                  preventCurveOverShooting: true,
                                  // preventCurveOvershootingThreshold: 10.6,
                                  isCurved: true,
                                  spots: glucose_spots,

                                  // spots: [
                                  //   FlSpot(0, 1),
                                  //   FlSpot(1, 3),
                                  //   FlSpot(2, 10),
                                  //   FlSpot(3, 7),
                                  //   FlSpot(4, 12),
                                  //   FlSpot(5, 13),
                                  //   FlSpot(6, 17),
                                  //   FlSpot(7, 15),
                                  //   FlSpot(8, 20)
                                  // ],
                                  belowBarData: BarAreaData(
                                      gradient: LinearGradient(colors: [
                                        Colors.blue,
                                        Colors.purpleAccent
                                      ]),
                                      show: true))
                            ]),
                        swapAnimationDuration:
                            Duration(milliseconds: 150), // Optional
                        swapAnimationCurve: Curves.linear,
                      ),
                    ))),
              )),
          Card(
            color: Colors.grey[400],
            elevation: 15,
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "$_month month Calories Range Data for \nLast few Days(in g)",
                          // "Glucose Increased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.\nI think you have to reduce your glucose level a\nlittle bit! Don't worry Try to add these foods!",

                          // "Glucose Increased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.Try to take\nmore amount of carbohydrates food to increase\nyour glucose level and try to add these foods!",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
              child: Container(
                // width: double.infinity,
                // height: 300,
                width: double.infinity,
                height: 290,
                // padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                child: Card(
                    elevation: 20,
                    shadowColor: Colors.red[400],
                    child: Container(
                        // color: Colors.blueGrey[400],
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 13, 13, 13),
                      child: LineChart(
                        LineChartData(
                            minY: 350,
                            maxY: 2900,
                            // minX: _minX,
                            // maxX: _maxX,
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: false,
                                )),
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 20,
                                        interval: 1)),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 30,
                                        interval: 1000))),
                            lineBarsData: [
                              LineChartBarData(
                                  gradient: LinearGradient(colors: [
                                    Colors.black,
                                    Colors.grey,
                                    Colors.black
                                  ]),
                                  shadow: Shadow(color: Colors.yellow),
                                  preventCurveOverShooting: true,
                                  // preventCurveOvershootingThreshold: 10.6,
                                  isCurved: true,
                                  spots: calories_spots,

                                  // spots: [
                                  //   FlSpot(0, 1),
                                  //   FlSpot(1, 3),
                                  //   FlSpot(2, 10),
                                  //   FlSpot(3, 7),
                                  //   FlSpot(4, 12),
                                  //   FlSpot(5, 13),
                                  //   FlSpot(6, 17),
                                  //   FlSpot(7, 15),
                                  //   FlSpot(8, 20)
                                  // ],
                                  belowBarData: BarAreaData(
                                      gradient: LinearGradient(colors: [
                                        Colors.blue,
                                        Colors.purpleAccent
                                      ]),
                                      show: true))
                            ]),
                        swapAnimationDuration:
                            Duration(milliseconds: 150), // Optional
                        swapAnimationCurve: Curves.linear,
                      ),
                    ))),
              )),
        ],
      )),
    ));
  }
}

// Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Color(0xff68737d),
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 2:
//         text = const Text('MAR', style: style);
//         break;
//       case 5:
//         text = const Text('JUN', style: style);
//         break;
//       case 8:
//         text = const Text('SEP', style: style);
//         break;
//       default:
//         text = const Text('', style: style);
//         break;
//     }

//     return SideTitles(
//       axisSide: meta.axisSide,
//       space: 8.0,
//       child: text,
//     );
//   }
