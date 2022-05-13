import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_tutorial/screens/view_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  late DatabaseReference _ref;
  TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _ref = FirebaseDatabase.instance.ref().child("tasks");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Data"),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _taskController,
                    decoration: const InputDecoration(hintText: "Enter Task"),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Enter Task";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      _formkey.currentState!.save();
                      _ref.child("saran").push().set(_taskController.text).then(
                          (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewData())));
                    },
                    child: Text("Submit"),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
