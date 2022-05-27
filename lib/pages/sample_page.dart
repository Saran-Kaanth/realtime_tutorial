import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  List items = ["idly", "dosa", "jam"];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.amber,
              child: Center(child: Text(items[index])),
            );
          }),
    );
  }
}
