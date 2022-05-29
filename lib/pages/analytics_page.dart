import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:form_controller/form_controller.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late DatabaseReference _ref;
  FirebaseAuth _instance = FirebaseAuth.instance;
  DateFormat dateFormat_1 = DateFormat("yyyy-MM-dd");
  DateFormat dateFormat_2 = DateFormat(" hh:mm:ss");
  final _random = Random();
  // Color? _randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)][Random.nextInt(9) * 100];

  // FormController _formController = FormController();
  List fullDataList = [];
  List items = [];

  var date_1 = "";
  var glucose_1 = "";
  String cal_1 = "";
  String pro_1 = "";
  String carb_1 = "";

  String date_2 = "";
  String glucose_2 = "";
  String cal_2 = "";
  String pro_2 = "";
  String carb_2 = "";

  String recomMsg = "";
  Map _avgData = {};
  var cal_diff = 0.0;
  var glu_diff = 0.0;
  late Icon com_arrow;
  late Icon glu_com_arrow_1;
  late Icon glu_com_arrow_2;
  late Icon cal_com_arrow_1;
  late Icon cal_com_arrow_2;

  Color _textColor = Colors.black;

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
    // q
    super.initState();
    com_arrow = Icon(Icons.arrow_back);
    glu_com_arrow_1 = Icon(Icons.compare_arrows_sharp);
    glu_com_arrow_2 = Icon(Icons.compare_arrows_sharp);
    cal_com_arrow_1 = Icon(Icons.compare_arrows_sharp);
    cal_com_arrow_2 = Icon(Icons.compare_arrows_sharp);

    _ref = FirebaseDatabase.instance.ref("users");
    items = [];

    recomMsg = "Need Some data for recommendation!";
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
    final ref = FirebaseDatabase.instance
        .ref("users")
        .child(_instance.currentUser!.uid)
        .child("all_data")
        .child(months[DateTime.now().month - 1])
        .once()
        .then((value) {
      if (value.snapshot.value != null) {
        Map all_data = value.snapshot.value as Map;

        // for (Map item in _recentAnalytics) {
        //   print(item["date"]);
        // }
        setState(() {
          print(all_data.keys);
          final sortedAllData = SplayTreeMap<String, dynamic>.from(
              all_data, (keys1, keys2) => keys1.compareTo(keys2));
          print(sortedAllData.keys);
          for (var key in sortedAllData.keys) {
            // print(key);
            // print(all_data[key]);
            fullDataList.add(all_data[key]);
          }

          // fullDataList.add(all_data);
          // print(fullDataList);
          // print(fullDataList.length);
          int len = fullDataList.length;
          List _recentAnalytics = [
            fullDataList[len - 1],
            fullDataList[len - 2]
          ];
          var firstData = fullDataList[len - 1];
          date_1 = firstData["date"];
          glucose_1 = firstData["glucoseData"].toStringAsFixed(2);
          cal_1 = firstData["foodData"]["total_nutrients"]["total_cal_g"]
              .toStringAsFixed(2);

          pro_1 = firstData["foodData"]["total_nutrients"]["total_protein_g"]
              .toStringAsFixed(2);
          carb_1 = firstData["foodData"]["total_nutrients"]["total_carbs_g"]
              .toStringAsFixed(2);

          var secondData = fullDataList[len - 2];
          date_2 = secondData["date"].toString();
          glucose_2 = secondData["glucoseData"].toStringAsFixed(2);
          cal_2 = secondData["foodData"]["total_nutrients"]["total_cal_g"]
              .toStringAsFixed(2);
          pro_2 = secondData["foodData"]["total_nutrients"]["total_protein_g"]
              .toStringAsFixed(2);
          carb_2 = secondData["foodData"]["total_nutrients"]["total_carbs_g"]
              .toStringAsFixed(2);

          com_arrow = Icon(Icons.arrow_drop_down_sharp);
          glu_diff = (firstData["glucoseData"] - secondData["glucoseData"])
              .abs()
              .ceilToDouble();
          // print(glu_diff);
          // print("hello");
          cal_diff = (firstData["foodData"]["total_nutrients"]["total_cal_g"] -
                  secondData["foodData"]["total_nutrients"]["total_cal_g"])
              .abs()
              .ceilToDouble();

          if (_avgData["avgGlucose"] > 85 && _avgData["avgGlucose"] < 120) {
            _textColor = Colors.green;

            // items = [firstData["foodData"].keys];
            List newItems = [];
            newItems = firstData["foodData"].keys.toList();
            newItems.addAll(secondData["foodData"].keys.toList());
            for (var item in newItems.toSet()) {
              if (item != "total_nutrients") {
                items.add(item);
              }

              // print(cal_diff);
              if (firstData["glucoseData"] > secondData["glucoseData"]) {
                glu_com_arrow_1 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                glu_com_arrow_2 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
                if (firstData["foodData"]["total_nutrients"]["total_cal_g"] >
                    secondData["foodData"]["total_nutrients"]["total_cal_g"]) {
                  recomMsg =
                      "Glucose Increased by $glu_diff mg/dL and \nCalories increased by $cal_diff g.\nYou're good to go! you can take these foods!";
                  cal_com_arrow_1 = Icon(
                    Icons.arrow_drop_up_rounded,
                    color: Colors.green,
                  );
                  cal_com_arrow_2 = Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.red,
                  );
                } else {
                  cal_com_arrow_1 = Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.red,
                  );
                  cal_com_arrow_2 = Icon(
                    Icons.arrow_drop_up_rounded,
                    color: Colors.green,
                  );
                  recomMsg =
                      "Glucose Increased by $glu_diff mg/dL and \nCalories decreased by $cal_diff g.\nYou're good to go! you can take these foods!";
                }
              } else {
                print(glu_diff);
                print(cal_diff);
                glu_com_arrow_1 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
                glu_com_arrow_2 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                if (firstData["foodData"]["total_nutrients"]["total_cal_g"] >
                    secondData["foodData"]["total_nutrients"]["total_cal_g"]) {
                  cal_com_arrow_1 = Icon(
                    Icons.arrow_drop_up_rounded,
                    color: Colors.green,
                  );
                  cal_com_arrow_2 = Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.red,
                  );
                  recomMsg =
                      "Glucose decreased by $glu_diff mg/dL and \nCalories increased by $cal_diff g.\nYou're good to go! you can take these foods!";
                } else {
                  cal_com_arrow_1 = Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.red,
                  );
                  cal_com_arrow_2 = Icon(
                    Icons.arrow_drop_up_rounded,
                    color: Colors.green,
                  );
                  recomMsg =
                      "Glucose decreased by $glu_diff mg/dL and \nCalories decreased by $cal_diff g.\nYou're good to go! you can take these foods!";
                }
              }
            }
            // print(recomMsg);
            // print(firstData["foodData"]["total_nutrients"]);
          } else if (_avgData["avgGlucose"] < 85) {
            _textColor = Color.fromARGB(255, 212, 152, 1);

            // recomMsg =
            //     "Try to take more amount of carbohydrates food to \nincrease your glucose level and try to add this";
            items = [
              "apple",
              "banana",
              "grapes",
              "pineapple",
              "grapefruit",
              "orange",
              "fat free milk",
              "honey",
              "sugar water",
              "raisins"
            ];
            if (firstData["glucoseData"] > secondData["glucoseData"]) {
              glu_com_arrow_1 = Icon(
                Icons.arrow_drop_up_rounded,
                color: Colors.green,
              );
              glu_com_arrow_2 = Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.red,
              );
              if (firstData["foodData"]["total_nutrients"]["total_cal_g"] >
                  secondData["foodData"]["total_nutrients"]["total_cal_g"]) {
                recomMsg =
                    "Glucose Increased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.Try to take\nmore amount of carbohydrates food to increase\nyour glucose level and try to add these foods!";
                cal_com_arrow_1 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                cal_com_arrow_2 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
              } else {
                cal_com_arrow_1 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
                cal_com_arrow_2 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                recomMsg =
                    "Glucose Increased by $glu_diff mg/dL and\nCalories decreased by $cal_diff g.Try to take\nmore amount of carbohydrates food to increase\nyour glucose level and try to add these foods!";
              }
            } else {
              print(glu_diff);
              print(cal_diff);
              glu_com_arrow_1 = Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.red,
              );
              glu_com_arrow_2 = Icon(
                Icons.arrow_drop_up_rounded,
                color: Colors.green,
              );
              if (firstData["foodData"]["total_nutrients"]["total_cal_g"] >
                  secondData["foodData"]["total_nutrients"]["total_cal_g"]) {
                cal_com_arrow_1 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                cal_com_arrow_2 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
                recomMsg =
                    "Glucose decreased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.Try to take\nmore amount of carbohydrates food to increase\nyour glucose level and try to add these foods!";
              } else {
                cal_com_arrow_1 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
                cal_com_arrow_2 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                recomMsg =
                    "Glucose decreased by $glu_diff mg/dL and\nCalories decreased by $cal_diff g.Try to take\nmore amount of carbohydrates food to increase\nyour glucose level and try to add these foods!";
              }
            }
          } else if (_avgData["avgGlucose"] > 120) {
            _textColor = Color.fromARGB(255, 215, 60, 12);

            items = [
              "Broccoli",
              "Broccoli Sprouts",
              "Seafood",
              "Pumpkin and seeds",
              "Nuts",
              "Okra",
              "Beans",
              "Berries",
              "Avocados",
              "Oats",
              "Orange",
              "Lemon",
              "Apple",
              "Yogurt",
              "Eggs"
            ];
            if (firstData["glucoseData"] > secondData["glucoseData"]) {
              glu_com_arrow_1 = Icon(
                Icons.arrow_drop_up_rounded,
                color: Colors.green,
              );
              glu_com_arrow_2 = Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.red,
              );
              if (firstData["foodData"]["total_nutrients"]["total_cal_g"] >
                  secondData["foodData"]["total_nutrients"]["total_cal_g"]) {
                recomMsg =
                    "Glucose Increased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.\nI think you have to reduce your glucose level a\nlittle bit! Don't worry Try to add these foods!";
                cal_com_arrow_1 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                cal_com_arrow_2 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
              } else {
                cal_com_arrow_1 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
                cal_com_arrow_2 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                recomMsg =
                    "Glucose Increased by $glu_diff mg/dL and\nCalories decreased by $cal_diff g.\nI think you have to reduce your glucose level a\nlittle bit! Don't worry Try to add these foods!";
              }
            } else {
              print(glu_diff);
              print(cal_diff);
              glu_com_arrow_1 = Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.red,
              );
              glu_com_arrow_2 = Icon(
                Icons.arrow_drop_up_rounded,
                color: Colors.green,
              );
              if (firstData["foodData"]["total_nutrients"]["total_cal_g"] >
                  secondData["foodData"]["total_nutrients"]["total_cal_g"]) {
                cal_com_arrow_1 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                cal_com_arrow_2 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
                recomMsg =
                    "Glucose decreased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.\nI think you have to reduce your glucose level a\nlittle bit! Don't worry Try to add these foods!";
              } else {
                cal_com_arrow_1 = Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.red,
                );
                cal_com_arrow_2 = Icon(
                  Icons.arrow_drop_up_rounded,
                  color: Colors.green,
                );
                recomMsg =
                    "Glucose decreased by $glu_diff mg/dL and\nCalories decreased by $cal_diff g.\nI think you have to reduce your glucose level a\nlittle bit! Don't worry Try to add these foods!";
              }
            }
          }
        });
      } else {
        print("null");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
      SizedBox(
        height: 5,
      ),
      Row(
        children: [
          Text(
            " Recommendation",
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              elevation: 15,
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Comparing Data for recommendation",
                              style: TextStyle(color: Colors.red, fontSize: 17),
                            ),
                            com_arrow
                          ],
                        )
                      ]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  // color: Colors.grey[400],
                  // shape: ShapeBorder(),
                  elevation: 15,
                  shadowColor: Colors.green,
                  child: SizedBox(
                    width: 140,
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Date",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                            Text(
                              "Glucose(mg/dL)",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                            Text(
                              "Calories(g)",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                            Text(
                              "Proteins(g)",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                            Text(
                              "Carbs(g)",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                          ]),
                    ),
                  ),
                ),
                Card(
                  // color: Colors.grey[400],
                  // shape: ShapeBorder(),
                  elevation: 15,
                  shadowColor: Colors.green,
                  child: SizedBox(
                    width: 120,
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "$date_2",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.purple),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$glucose_2",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.purple),
                                ),
                                glu_com_arrow_2
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$cal_2",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.purple),
                                ),
                                cal_com_arrow_2
                              ],
                            ),
                            Text(
                              "$pro_2",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.purple),
                            ),
                            Text(
                              "$carb_2",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.purple),
                            ),
                          ]),
                    ),
                  ),
                ),
                Card(
                  // color: Colors.grey[400],
                  // shape: ShapeBorder(),
                  elevation: 15,
                  shadowColor: Colors.green,
                  child: SizedBox(
                    width: 120,
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "$date_1",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.purple),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$glucose_1",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.purple),
                                ),
                                glu_com_arrow_1
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$cal_1",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.purple),
                                ),
                                cal_com_arrow_1
                              ],
                            ),
                            Text(
                              "$pro_1",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.purple),
                            ),
                            Text(
                              "$carb_1",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.purple),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 15,
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              recomMsg,
                              // "Glucose Increased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.\nI think you have to reduce your glucose level a\nlittle bit! Don't worry Try to add these foods!",

                              // "Glucose Increased by $glu_diff mg/dL and\nCalories increased by $cal_diff g.Try to take\nmore amount of carbohydrates food to increase\nyour glucose level and try to add these foods!",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: 500,
                child: GridView.builder(
                    shrinkWrap: true,
                    // padding: EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 2.3),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Color.fromARGB(
                            _random.nextInt(256),
                            _random.nextInt(256),
                            _random.nextInt(256),
                            _random.nextInt(256)),
                        child: Center(
                            child: Text(
                          items[index],
                          style: TextStyle(fontSize: 25),
                        )),
                        elevation: 5,
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    ]))));
  }
}
