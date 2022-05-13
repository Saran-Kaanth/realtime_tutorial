import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_tutorial/screens/view_data.dart';

class UpdateScreen extends StatefulWidget {
  final String value;
  // ignore: use_key_in_widget_constructors
  const UpdateScreen({required this.value});
  // const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  final _ref = FirebaseDatabase.instance.ref().child("tasks");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Screen"),
        ),
        body: Padding(
          padding: EdgeInsets.all(50.0),
          child: Center(
              child: Form(
            key: _formkey,
            child: Column(children: [
              TextFormField(
                controller: _taskController,
                decoration: InputDecoration(hintText: "Enter updated value"),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Enter some value";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              RaisedButton(
                onPressed: () {
                  if (!_formkey.currentState!.validate()) {
                    return;
                  }
                  _formkey.currentState!.save();

                  String _text = _taskController.text;
                  _ref.child(widget.value).set(_text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ViewData()));
                },
                child: Text("Update"),
              )
            ]),
          )),
        ));
  }
}
