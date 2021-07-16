import 'package:flutter/material.dart';
import 'package:learner/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Job interview app"),
          shadowColor: Colors.black,
        ),
        body: MyWidget(),
      ),
    );
  }
}
