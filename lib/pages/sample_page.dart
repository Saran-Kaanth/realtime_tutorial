import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  FirebaseAuth _instance = FirebaseAuth.instance;
  late DatabaseReference _ref;

  List items = ["idly", "dosa", "jam"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _ref = FirebaseDatabase.instance.ref("users");
    _ref.set({
      "FddU7K4vONhrIxklCRO9LRj4GHo2": {
        "MedicalId": {
          "blood_type": "O+ve",
          "dob": "2022-05-11",
          "emergency_1": 8056356310,
          "emergency_2": 9600982700,
          "height": 5.6,
          "medical_conditions": "None",
          "medication": "Monticope",
          "name": "Lakshmanan ",
          "weight": 68.5
        },
        "all_data": {
          "avg": {
            "jun": {
              "avgCalories": 974.9000000000001,
              "avgCarbs": 99.39999999999999,
              "avgCholes": 286.5,
              "avgFat": 44.74999999999999,
              "avgGlucose": 91.75,
              "avgProtein": 43.05
            },
            "may": {
              "avgCalories": 974.9000000000001,
              "avgCarbs": 99.39999999999999,
              "avgCholes": 286.5,
              "avgFat": 44.74999999999999,
              "avgGlucose": 91.75,
              "avgProtein": 43.05
            }
          },
          "jun": {
            "1": {
              "date": "2022-06-01",
              "foodData": {
                "bread": {
                  "calories": 261.6,
                  "carbohydrates_total_g": 50.2,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0.7,
                  "fat_total_g": 3.4,
                  "fiber_g": 2.7,
                  "name": "bread",
                  "potassium_mg": 98,
                  "protein_g": 8.8,
                  "serving_size_g": 100,
                  "sodium_mg": 495,
                  "sugar_g": 5.7
                },
                "chicken": {
                  "calories": 222.6,
                  "carbohydrates_total_g": 0,
                  "cholesterol_mg": 92,
                  "fat_saturated_g": 3.7,
                  "fat_total_g": 12.9,
                  "fiber_g": 0,
                  "name": "chicken",
                  "potassium_mg": 179,
                  "protein_g": 23.7,
                  "serving_size_g": 100,
                  "sodium_mg": 72,
                  "sugar_g": 0
                },
                "chocolate": {
                  "calories": 540.2,
                  "carbohydrates_total_g": 58.9,
                  "cholesterol_mg": 23,
                  "fat_saturated_g": 18.6,
                  "fat_total_g": 29.4,
                  "fiber_g": 3.4,
                  "name": "chocolate",
                  "potassium_mg": 206,
                  "protein_g": 7.8,
                  "serving_size_g": 100,
                  "sodium_mg": 78,
                  "sugar_g": 51.4
                },
                "fish": {
                  "calories": 129.2,
                  "carbohydrates_total_g": 0,
                  "cholesterol_mg": 56,
                  "fat_saturated_g": 0.9,
                  "fat_total_g": 2.7,
                  "fiber_g": 0,
                  "name": "fish",
                  "potassium_mg": 203,
                  "protein_g": 26,
                  "serving_size_g": 100,
                  "sodium_mg": 57,
                  "sugar_g": 0
                },
                "juice": {
                  "calories": 53.7,
                  "carbohydrates_total_g": 13.3,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0,
                  "fat_total_g": 0,
                  "fiber_g": 0.1,
                  "name": "juice",
                  "potassium_mg": 6,
                  "protein_g": 0.1,
                  "serving_size_g": 100,
                  "sodium_mg": 61,
                  "sugar_g": 12.2
                },
                "mutton": {
                  "calories": 289.6,
                  "carbohydrates_total_g": 0,
                  "cholesterol_mg": 98,
                  "fat_saturated_g": 8.9,
                  "fat_total_g": 21.3,
                  "fiber_g": 0,
                  "name": "mutton",
                  "potassium_mg": 184,
                  "protein_g": 24.4,
                  "serving_size_g": 100,
                  "sodium_mg": 72,
                  "sugar_g": 0
                },
                "peanuts": {
                  "calories": 600.9,
                  "carbohydrates_total_g": 20.8,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 8.1,
                  "fat_total_g": 49.9,
                  "fiber_g": 8.1,
                  "name": "peanuts",
                  "potassium_mg": 356,
                  "protein_g": 24.1,
                  "serving_size_g": 100,
                  "sodium_mg": 415,
                  "sugar_g": 5
                },
                "rice": {
                  "calories": 127.4,
                  "carbohydrates_total_g": 28.4,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0.1,
                  "fat_total_g": 0.3,
                  "fiber_g": 0.4,
                  "name": "rice",
                  "potassium_mg": 42,
                  "protein_g": 2.7,
                  "serving_size_g": 100,
                  "sodium_mg": 1,
                  "sugar_g": 0.1
                },
                "total_nutrients": {
                  "total_cal_g": 2225.2000000000003,
                  "total_carbs_g": 171.60000000000002,
                  "total_cholesterol_mg": 269,
                  "total_fat_g": 119.89999999999999,
                  "total_protein_g": 117.6,
                  "total_sugar_g": 74.39999999999999
                }
              },
              "glucoseData": 68.5
            },
            "2": {
              "date": "2022-06-02",
              "foodData": {
                "apple": {
                  "calories": 53,
                  "carbohydrates_total_g": 14.1,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0,
                  "fat_total_g": 0.2,
                  "fiber_g": 2.4,
                  "name": "apple",
                  "potassium_mg": 11,
                  "protein_g": 0.3,
                  "serving_size_g": 100,
                  "sodium_mg": 1,
                  "sugar_g": 10.3
                },
                "broccoli": {
                  "calories": 35,
                  "carbohydrates_total_g": 7.3,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0.1,
                  "fat_total_g": 0.4,
                  "fiber_g": 3.3,
                  "name": "broccoli",
                  "potassium_mg": 65,
                  "protein_g": 2.4,
                  "serving_size_g": 100,
                  "sodium_mg": 41,
                  "sugar_g": 1.4
                },
                "carrot": {
                  "calories": 34,
                  "carbohydrates_total_g": 8.3,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0,
                  "fat_total_g": 0.2,
                  "fiber_g": 3,
                  "name": "carrot",
                  "potassium_mg": 30,
                  "protein_g": 0.8,
                  "serving_size_g": 100,
                  "sodium_mg": 57,
                  "sugar_g": 3.4
                },
                "chicken": {
                  "calories": 222.6,
                  "carbohydrates_total_g": 0,
                  "cholesterol_mg": 92,
                  "fat_saturated_g": 3.7,
                  "fat_total_g": 12.9,
                  "fiber_g": 0,
                  "name": "chicken",
                  "potassium_mg": 179,
                  "protein_g": 23.7,
                  "serving_size_g": 100,
                  "sodium_mg": 72,
                  "sugar_g": 0
                },
                "chocolate": {
                  "calories": 540.2,
                  "carbohydrates_total_g": 58.9,
                  "cholesterol_mg": 23,
                  "fat_saturated_g": 18.6,
                  "fat_total_g": 29.4,
                  "fiber_g": 3.4,
                  "name": "chocolate",
                  "potassium_mg": 206,
                  "protein_g": 7.8,
                  "serving_size_g": 100,
                  "sodium_mg": 78,
                  "sugar_g": 51.4
                },
                "idly": {
                  "calories": 149.5,
                  "carbohydrates_total_g": 30.4,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0.2,
                  "fat_total_g": 1.1,
                  "fiber_g": 1.4,
                  "name": "idly",
                  "potassium_mg": 70,
                  "protein_g": 4.3,
                  "serving_size_g": 100,
                  "sodium_mg": 193,
                  "sugar_g": 0.3
                },
                "milk": {
                  "calories": 51.3,
                  "carbohydrates_total_g": 4.9,
                  "cholesterol_mg": 8,
                  "fat_saturated_g": 1.2,
                  "fat_total_g": 1.9,
                  "fiber_g": 0,
                  "name": "milk",
                  "potassium_mg": 100,
                  "protein_g": 3.5,
                  "serving_size_g": 100,
                  "sodium_mg": 52,
                  "sugar_g": 0
                },
                "noodles": {
                  "calories": 161.8,
                  "carbohydrates_total_g": 31.2,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0.2,
                  "fat_total_g": 0.9,
                  "fiber_g": 1.8,
                  "name": "noodles",
                  "potassium_mg": 57,
                  "protein_g": 5.8,
                  "serving_size_g": 100,
                  "sodium_mg": 0,
                  "sugar_g": 0.6
                },
                "orange": {
                  "calories": 50.4,
                  "carbohydrates_total_g": 12.4,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0,
                  "fat_total_g": 0.1,
                  "fiber_g": 2.2,
                  "name": "orange",
                  "potassium_mg": 23,
                  "protein_g": 0.9,
                  "serving_size_g": 100,
                  "sodium_mg": 1,
                  "sugar_g": 8.4
                },
                "rice": {
                  "calories": 127.4,
                  "carbohydrates_total_g": 28.4,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0.1,
                  "fat_total_g": 0.3,
                  "fiber_g": 0.4,
                  "name": "rice",
                  "potassium_mg": 42,
                  "protein_g": 2.7,
                  "serving_size_g": 100,
                  "sodium_mg": 1,
                  "sugar_g": 0.1
                },
                "total_nutrients": {
                  "total_cal_g": 1425.2000000000003,
                  "total_carbs_g": 195.9,
                  "total_cholesterol_mg": 123,
                  "total_fat_g": 47.400000000000006,
                  "total_protein_g": 52.19999999999999,
                  "total_sugar_g": 75.9
                }
              },
              "glucoseData": 75.8
            },
            "3": {
              "date": "2022-06-03",
              "foodData": {
                "chicken": {
                  "calories": 222.6,
                  "carbohydrates_total_g": 0,
                  "cholesterol_mg": 92,
                  "fat_saturated_g": 3.7,
                  "fat_total_g": 12.9,
                  "fiber_g": 0,
                  "name": "chicken",
                  "potassium_mg": 179,
                  "protein_g": 23.7,
                  "serving_size_g": 100,
                  "sodium_mg": 72,
                  "sugar_g": 0
                },
                "dosa": {
                  "calories": 170.5,
                  "carbohydrates_total_g": 30,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0.6,
                  "fat_total_g": 3.8,
                  "fiber_g": 0.9,
                  "name": "dosa",
                  "potassium_mg": 52,
                  "protein_g": 4,
                  "serving_size_g": 100,
                  "sodium_mg": 97,
                  "sugar_g": 0.2
                },
                "eggs": {
                  "calories": 144.3,
                  "carbohydrates_total_g": 0.7,
                  "cholesterol_mg": 373,
                  "fat_saturated_g": 3.1,
                  "fat_total_g": 9.4,
                  "fiber_g": 0,
                  "name": "eggs",
                  "potassium_mg": 200,
                  "protein_g": 12.6,
                  "serving_size_g": 100,
                  "sodium_mg": 143,
                  "sugar_g": 0.4
                },
                "juice": {
                  "calories": 53.7,
                  "carbohydrates_total_g": 13.3,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0,
                  "fat_total_g": 0,
                  "fiber_g": 0.1,
                  "name": "juice",
                  "potassium_mg": 6,
                  "protein_g": 0.1,
                  "serving_size_g": 100,
                  "sodium_mg": 61,
                  "sugar_g": 12.2
                },
                "parotta": {
                  "calories": 326.8,
                  "carbohydrates_total_g": 44.7,
                  "cholesterol_mg": 1,
                  "fat_saturated_g": 5.9,
                  "fat_total_g": 13.3,
                  "fiber_g": 9.7,
                  "name": "parotta",
                  "potassium_mg": 117,
                  "protein_g": 6.3,
                  "serving_size_g": 100,
                  "sodium_mg": 454,
                  "sugar_g": 4.2
                },
                "pongal": {
                  "calories": 156.4,
                  "carbohydrates_total_g": 26.4,
                  "cholesterol_mg": 7,
                  "fat_saturated_g": 2.1,
                  "fat_total_g": 3.8,
                  "fiber_g": 1.9,
                  "name": "pongal",
                  "potassium_mg": 53,
                  "protein_g": 3.5,
                  "serving_size_g": 100,
                  "sodium_mg": 1,
                  "sugar_g": 0.5
                },
                "rice": {
                  "calories": 127.4,
                  "carbohydrates_total_g": 28.4,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0.1,
                  "fat_total_g": 0.3,
                  "fiber_g": 0.4,
                  "name": "rice",
                  "potassium_mg": 42,
                  "protein_g": 2.7,
                  "serving_size_g": 100,
                  "sodium_mg": 1,
                  "sugar_g": 0.1
                },
                "total_nutrients": {
                  "total_cal_g": 1201.6999999999998,
                  "total_carbs_g": 143.5,
                  "total_cholesterol_mg": 473,
                  "total_fat_g": 43.5,
                  "total_protein_g": 52.900000000000006,
                  "total_sugar_g": 17.599999999999998
                }
              },
              "glucoseData": 75.6
            }
          },
          "may": {
            "26": {
              "date": "2022-05-26",
              "foodData": {
                "apple": {
                  "calories": 53,
                  "carbohydrates_total_g": 14.1,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0,
                  "fat_total_g": 0.2,
                  "fiber_g": 2.4,
                  "name": "apple",
                  "potassium_mg": 11,
                  "protein_g": 0.3,
                  "serving_size_g": 100,
                  "sodium_mg": 1,
                  "sugar_g": 10.3
                },
                "biscuits": {
                  "calories": 346.1,
                  "carbohydrates_total_g": 44.8,
                  "cholesterol_mg": 2,
                  "fat_saturated_g": 4.3,
                  "fat_total_g": 16.3,
                  "fiber_g": 1.5,
                  "name": "biscuits",
                  "potassium_mg": 162,
                  "protein_g": 6.9,
                  "serving_size_g": 100,
                  "sodium_mg": 588,
                  "sugar_g": 2.2
                },
                "chicken": {
                  "calories": 222.6,
                  "carbohydrates_total_g": 0,
                  "cholesterol_mg": 92,
                  "fat_saturated_g": 3.7,
                  "fat_total_g": 12.9,
                  "fiber_g": 0,
                  "name": "chicken",
                  "potassium_mg": 179,
                  "protein_g": 23.7,
                  "serving_size_g": 100,
                  "sodium_mg": 72,
                  "sugar_g": 0
                },
                "chocolate": {
                  "calories": 540.2,
                  "carbohydrates_total_g": 58.9,
                  "cholesterol_mg": 23,
                  "fat_saturated_g": 18.6,
                  "fat_total_g": 29.4,
                  "fiber_g": 3.4,
                  "name": "chocolate",
                  "potassium_mg": 206,
                  "protein_g": 7.8,
                  "serving_size_g": 100,
                  "sodium_mg": 78,
                  "sugar_g": 51.4
                },
                "eggs": {
                  "calories": 144.3,
                  "carbohydrates_total_g": 0.7,
                  "cholesterol_mg": 373,
                  "fat_saturated_g": 3.1,
                  "fat_total_g": 9.4,
                  "fiber_g": 0,
                  "name": "eggs",
                  "potassium_mg": 200,
                  "protein_g": 12.6,
                  "serving_size_g": 100,
                  "sodium_mg": 143,
                  "sugar_g": 0.4
                },
                "fish": {
                  "calories": 129.2,
                  "carbohydrates_total_g": 0,
                  "cholesterol_mg": 56,
                  "fat_saturated_g": 0.9,
                  "fat_total_g": 2.7,
                  "fiber_g": 0,
                  "name": "fish",
                  "potassium_mg": 203,
                  "protein_g": 26,
                  "serving_size_g": 100,
                  "sodium_mg": 57,
                  "sugar_g": 0
                },
                "idly": {
                  "calories": 149.5,
                  "carbohydrates_total_g": 30.4,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0.2,
                  "fat_total_g": 1.1,
                  "fiber_g": 1.4,
                  "name": "idly",
                  "potassium_mg": 70,
                  "protein_g": 4.3,
                  "serving_size_g": 100,
                  "sodium_mg": 193,
                  "sugar_g": 0.3
                },
                "juice": {
                  "calories": 53.7,
                  "carbohydrates_total_g": 13.3,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0,
                  "fat_total_g": 0,
                  "fiber_g": 0.1,
                  "name": "juice",
                  "potassium_mg": 6,
                  "protein_g": 0.1,
                  "serving_size_g": 100,
                  "sodium_mg": 61,
                  "sugar_g": 12.2
                },
                "orange": {
                  "calories": 50.4,
                  "carbohydrates_total_g": 12.4,
                  "cholesterol_mg": 0,
                  "fat_saturated_g": 0,
                  "fat_total_g": 0.1,
                  "fiber_g": 2.2,
                  "name": "orange",
                  "potassium_mg": 23,
                  "protein_g": 0.9,
                  "serving_size_g": 100,
                  "sodium_mg": 1,
                  "sugar_g": 8.4
                },
                "samosa": {
                  "calories": 260.8,
                  "carbohydrates_total_g": 24.2,
                  "cholesterol_mg": 27,
                  "fat_saturated_g": 7.1,
                  "fat_total_g": 17.4,
                  "fiber_g": 2.1,
                  "name": "samosa",
                  "potassium_mg": 52,
                  "protein_g": 3.5,
                  "serving_size_g": 100,
                  "sodium_mg": 426,
                  "sugar_g": 1.6
                },
                "total_nutrients": {
                  "total_cal_g": 1949.8000000000002,
                  "total_carbs_g": 198.79999999999998,
                  "total_cholesterol_mg": 573,
                  "total_fat_g": 89.49999999999999,
                  "total_protein_g": 86.1,
                  "total_sugar_g": 86.8
                }
              },
              "glucoseData": 103.5
            }
          }
        },
        "login_data": {
          "date_created": "2022-05-26",
          "display_name": "LAKSHMANAN S",
          "user_email": "saran16kaanth@gmail.com",
          "verified": true
        }
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      // child: GridView.builder(
      //     padding: EdgeInsets.all(10),
      //     // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     //   crossAxisCount: 2,
      //     // ),
      //     itemCount: items.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Card(
      //         color: Colors.amber,
      //         child: Center(child: Text(items[index])),
      //       );
      //     }),
    );
  }
}
