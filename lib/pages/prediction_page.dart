import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key}) : super(key: key);

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  // var client = Client();
  var url = "https://api.calorieninjas.com/v1/nutrition?query=";
  var query = "idly";

  var client = http.Client();
  void main(String query) async {
    var queryParameters = {
      'query': query,
    };

    var headers = {'x-api-key': '7VSkbFyyllYBIKwvFsEa5A==U0b9u9ct9A209r0Y'};

    var url =
        Uri.https('api.calorieninjas.com', '/v1/nutrition', queryParameters);
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      print('$jsonResponse');
    } else {
      print('Reponse error with code ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Column(
        children: [
          Text(
            "Prediction Page",
            style: TextStyle(fontSize: 40),
          ),
          IconButton(
              onPressed: () {
                main("idly");
              },
              icon: Icon(Icons.search))
        ],
      )),
    ));
  }
}
