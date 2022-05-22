import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  static List<String> foodsList = [""];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // var client = http.Client();
  Future<Map> main(String _reqBody) async {
    var queryParameters = {
      'query': _reqBody,
    };

    var headers = {'x-api-key': '7VSkbFyyllYBIKwvFsEa5A==U0b9u9ct9A209r0Y'};

    var url =
        Uri.https('api.calorieninjas.com', '/v1/nutrition', queryParameters);

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final foodVal = jsonResponse;
      print(foodVal.runtimeType);
      print("hii");
      print('$foodVal');
      return foodVal;

      // print(jsonResponse['items'][0]["protein_g"]);

      // print(jsonResponse["items"]);
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Dynamic TextFormFields'),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name textfield
                  Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: 'Enter your name'),
                      validator: (v) {
                        if (v!.trim().isEmpty) return 'Please enter something';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add Foods',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  ..._getFoods(),
                  SizedBox(
                    height: 40,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(foodsList);
                        int len = foodsList.length;
                        int ori_len = len - 1;
                        print(ori_len);
                        var total_cal = 0;
                        var total_protein = 0;
                        var total_fat = 0;
                        var total_cholesterol = 0;
                        var total_sugar = 0;
                        while (ori_len >= 0) {
                          // print(foodsList[ori_len]);
                          // ori_len--;
                          Future<Map> value = main(foodsList[ori_len]);
                          print("check");
                          print(value.runtimeType);
                          print(value["items"];
                          ori_len--;
                        }
                      }
                    },
                    child: Text('Submit'),
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  /// get foods text-fields
  List<Widget> _getFoods() {
    List<Widget> foodsTextFields = [];
    for (int i = 0; i < foodsList.length; i++) {
      foodsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: FoodTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last Foods row
            _addRemoveButton(i == foodsList.length - 1, i),
          ],
        ),
      ));
    }
    return foodsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all Foods textfields
          foodsList.insert(0, "");
        } else
          foodsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FoodTextFields extends StatefulWidget {
  final int index;
  FoodTextFields(this.index);
  @override
  _FoodTextFieldsState createState() => _FoodTextFieldsState();
}

class _FoodTextFieldsState extends State<FoodTextFields> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _nameController.text = _MyFormState.foodsList[widget.index];
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _MyFormState.foodsList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter your Food name'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
