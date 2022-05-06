import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:realtime_tutorial/screens/update_screen.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child("tasks");
    return Scaffold(
        appBar: AppBar(title: Text("View Data")),
        body: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    tileColor: Colors.indigo[100],
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              ref.child(snapshot.key!).remove();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateScreen(value: snapshot.key!)));
                            },
                            icon: Icon(
                              Icons.update,
                              color: Colors.green,
                            ))
                      ],
                    ),
                    title: Text(
                      snapshot.value.toString(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }));
  }
}
